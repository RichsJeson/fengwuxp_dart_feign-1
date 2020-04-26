import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/feign_client.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/request_mapping.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/signature.dart';
import 'package:fengwuxp_dart_openfeign/src/client/response_extractor.dart';
import 'package:fengwuxp_dart_openfeign/src/client/rest_response_extractor.dart';
import 'package:fengwuxp_dart_openfeign/src/configuration/feign_configuration.dart';
import 'package:fengwuxp_dart_openfeign/src/constant/feign_constant_var.dart';
import 'package:fengwuxp_dart_openfeign/src/constant/http/http_method.dart';
import 'package:fengwuxp_dart_openfeign/src/http/response_entity.dart';
import 'package:fengwuxp_dart_openfeign/src/interceptor/mapped_feign_client_executor_interceptor.dart';
import 'package:fengwuxp_dart_openfeign/src/utils/metadata_utils.dart';
import 'package:reflectable/reflectable.dart';

import '../feign_request_options.dart';
import 'feign_client_executor.dart';
import 'feign_client_executor_interceptor.dart';

class DefaultFeignClientExecutor implements FeignClientExecutor {
  /// proxy feign client type
  final Type targetType;

  //  proxy feign client type reflect mirror
  final ClassMirror classMirror;

  final FeignConfiguration feignConfiguration;

  FeignClient _feignClient;

  DefaultFeignClientExecutor(this.classMirror, this.targetType, this.feignConfiguration) {
    this._initFeignClient();
  }

  @override
  Future invoke(String methodName, List<Object> positionalArguments, [Map<Symbol, dynamic> namedArguments]) async {
    final feignConfiguration = this.feignConfiguration;

    //获取声明列表
    final classMirror = this.classMirror;
    final Map<String, DeclarationMirror> map = classMirror.declarations;
    final MethodMirror methodMirror = map[methodName];
    final classMetadata = methodMirror.metadata;
    final requestMapping = findRequestMapping(classMetadata) as RequestMapping;

    final parameters = methodMirror.parameters;

    /// 解析参数
    final requestParamsResolver = feignConfiguration.requestParamsResolver;
    var feignRequestOptions = requestParamsResolver.resolve(positionalArguments, parameters, requestMapping.method,
        options: namedArguments[FEIGN_OPTIONS_PARAMETER_NAME]);

    /// 解析url
    final requestURLResolver = feignConfiguration.requestURLResolver;
    final String requestUrl =
        requestURLResolver.resolve(this._feignClient, requestMapping, classMirror.simpleName, methodName);

    /// 解析请求头
    var requestHeaderResolver = feignConfiguration.requestHeaderResolver;
    requestHeaderResolver.resolve(requestMapping, feignRequestOptions.headers, feignRequestOptions.queryParams);
    var requestSupportRequestBody = supportRequestBody(requestMapping.method);
    if (requestSupportRequestBody == null) {
      requestHeaderResolver.resolve(requestMapping, feignRequestOptions.headers, feignRequestOptions.body);
    }

    /// TODO 解析cookie

    /// 处理签名
    final apiSignatureStrategy = feignConfiguration.apiSignatureStrategy;
    if (apiSignatureStrategy != null) {
      final signature = findMetadata(classMetadata, Signature) as Signature;
      // handle api signature
      apiSignatureStrategy.sign(signature.fields, feignRequestOptions);
    }
    if (feignRequestOptions.responseExtractor == null) {
      // get response extractor
      feignRequestOptions.responseExtractor =
          this._responseExtractor(requestMapping.method, namedArguments[Symbol(FEIGN_SERIALIZER_PARAMETER_NAME)]);
    }

    /// TODO 设置请求上下文ID

    /// 执行拦截器
    feignRequestOptions = await this._preHandle(feignRequestOptions, requestUrl, requestMapping);

    /// 发起请求
    final restTemplate = feignConfiguration.restTemplate;
    try {
      final response = await restTemplate.execute(
          requestUrl, requestMapping.method, feignRequestOptions.responseExtractor,
          request: feignRequestOptions.body,
          queryParams: feignRequestOptions.queryParams,
          pathVariables: feignRequestOptions.pathVariables);
      return this._postHandle(feignRequestOptions, requestUrl, requestMapping, response);
    } catch (e) {
      return this._postHandleError(feignRequestOptions, requestUrl, requestMapping, e);
    }
  }

  /// 前置拦截器
  Future _preHandle(FeignRequestOptions feignRequestOptions, String url, RequestMapping requestMapping) async {
    final feignClientExecutorInterceptors = this.feignConfiguration.feignClientExecutorInterceptors;
    var result = feignRequestOptions, len = feignClientExecutorInterceptors.length, index = 0;
    while (index < len) {
      var feignClientExecutorInterceptor = feignClientExecutorInterceptors[index];
      var interceptor =
          this._getInterceptor(feignClientExecutorInterceptor, url, feignRequestOptions.headers, requestMapping);
      if (interceptor != null) {
        result = await interceptor.preHandle(feignRequestOptions);
      }
      index++;
    }
    return result;
  }

  /// 拦截器后置处理
  Future _postHandle(
      FeignRequestOptions feignRequestOptions, String url, RequestMapping requestMapping, response) async {
    final feignClientExecutorInterceptors = this.feignConfiguration.feignClientExecutorInterceptors;
    var result = feignRequestOptions, len = feignClientExecutorInterceptors.length, index = 0;
    while (index < len) {
      var feignClientExecutorInterceptor = feignClientExecutorInterceptors[index];
      var interceptor =
          this._getInterceptor(feignClientExecutorInterceptor, url, feignRequestOptions.headers, requestMapping);
      if (interceptor != null) {
        result = await interceptor.postHandle(feignRequestOptions, response);
      }
      index++;
    }
    return result;
  }

  /// 拦截器后置错误处理
  Future _postHandleError(
      FeignRequestOptions feignRequestOptions, String url, RequestMapping requestMapping, response) async {
    final feignClientExecutorInterceptors = this.feignConfiguration.feignClientExecutorInterceptors;
    var result = feignRequestOptions, len = feignClientExecutorInterceptors.length, index = 0;
    while (index < len) {
      var feignClientExecutorInterceptor = feignClientExecutorInterceptors[index];
      var interceptor =
          this._getInterceptor(feignClientExecutorInterceptor, url, feignRequestOptions.headers, requestMapping);
      if (interceptor != null) {
        result = await interceptor.postError(feignRequestOptions, response);
      }
      index++;
    }
    return result;
  }

  FeignClientExecutorInterceptor _getInterceptor(FeignClientExecutorInterceptor feignClientExecutorInterceptor,
      String url, Map<String, String> headers, RequestMapping requestMapping) {
    if (feignClientExecutorInterceptor is MappedFeignClientExecutorInterceptor) {
      var isMatch =
          feignClientExecutorInterceptor.matches(url: url, httpMethod: requestMapping.method, headers: headers);
      if (!isMatch) {
        return null;
      }
      return feignClientExecutorInterceptor;
    }
    return feignClientExecutorInterceptor;
  }

  ResponseExtractor _responseExtractor<T>(String httpMethod, Serializer<T> serializer, {Type responseType}) {
    if (httpMethod == HttpMethod.OPTIONS) {
      return OptionsForAllowResponseExtractor();
    }
    if (httpMethod == HttpMethod.HEAD) {
      return HeadResponseExtractor();
    }

    if (responseType == null) {
      return HttpMessageConverterExtractor(feignConfiguration.messageConverters, serializer);
    }

    if (responseType == ResponseEntity) {
      return ResponseEntityResponseExtractor(feignConfiguration.messageConverters, serializer);
    }

    return null;
  }

  /// 初始化
  void _initFeignClient() {
    var feignClientMeta = findMetadata(this.classMirror.metadata, FeignClient);
    this._feignClient = feignClientMeta;
  }
}
