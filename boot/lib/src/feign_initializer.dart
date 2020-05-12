import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/index.dart';

import 'feign_configuration_boot.dart';
import 'feign_configuration_registry.dart';

void feignInitializer(FeignConfigurationRegistry registry, BuiltJsonSerializers builtJsonSerializers,
    {FeignClientExecutorFactory feignClientExecutorFactory,
    String defaultProduce = HttpMediaType.FORM_DATA,
    RestOperations restOperations,
    RequestURLResolver requestURLResolver,
    RequestParamsResolver requestParamsResolver,
    RequestHeaderResolver requestHeaderResolver,
    ApiSignatureStrategy apiSignatureStrategy,
    AuthenticationBroadcaster authenticationBroadcaster,
    FeignToastHandle feignToastHandle}) {
  registryFeignConfiguration(FeignConfigurationBoot(registry, builtJsonSerializers,
      feignClientExecutorFactory: feignClientExecutorFactory,
      defaultProduce: defaultProduce,
      restOperations: restOperations,
      requestURLResolver: requestURLResolver,
      requestParamsResolver: requestParamsResolver,
      requestHeaderResolver: requestHeaderResolver,
      apiSignatureStrategy: apiSignatureStrategy,
      authenticationBroadcaster: authenticationBroadcaster,
      feignToastHandle: feignToastHandle));
}
