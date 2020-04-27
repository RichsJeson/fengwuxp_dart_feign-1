import 'dart:async';

import 'package:fengwuxp_dart_openfeign/src/annotations/feign_client.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/path_variable.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/query_param.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/request_header.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/request_mapping.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/signature.dart';
import 'package:fengwuxp_dart_openfeign/src/feign_proxy_client.dart';
import 'package:fengwuxp_dart_openfeign/src/feign_request_options.dart';

import '../built/hello/hello.dart';
import '../built/req/query_hello_req.dart';

/// feign client
@FeignClient(name: "hello_client", value: "/")
class HelloFeignClient extends FeignProxyClient {
  /// 返回具体类型
  /// 为了能够返回具体类型 骗过 dart运行时泛型匹配使用如下方式调用
  @GetMapping(value: "/")
  Future<Hello> getHello(@RequestHeader() String name, @QueryParam() num id, [FeignRequestOptions feignOptions]) {
    return this.delegateInvoke<Hello>("getHello", [name, id], feignOptions: feignOptions, serializer: Hello.serializer);
  }

  /// 不返回具体类型  dart运行时泛型匹配的限制
  /// noSuchMethod 永远返回 Future<dynamic>
  @GetMapping(value: "/get_hello")
  Future getHelloForObject(@RequestHeader() String name, @QueryParam() num id, [FeignRequestOptions feignOptions]);

  @GetMapping(value: "/get_hello")
  @Signature(["id"])
  Future queryHello(QueryHelloReq req, [FeignRequestOptions feignOptions]);

  @GetMapping(value: "/get_hello/{id}")
  Future findHelloById(@PathVariable() String id, [FeignRequestOptions feignOptions]);
}
