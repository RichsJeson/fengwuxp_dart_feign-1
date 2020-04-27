import 'package:fengwuxp_dart_openfeign/src/annotations/feign_client.dart';
import 'package:fengwuxp_dart_openfeign/src/annotations/request_mapping.dart';
import 'package:fengwuxp_dart_openfeign/src/feign_proxy_client.dart';
import 'package:fengwuxp_dart_openfeign/src/feign_request_options.dart';

import 'info/article_action_info.dart';
import 'req/find_article_actions_req.dart';
import 'resp/page_info.dart';

/// 查询文章交互
@FeignClient(value: "/article_action")
class ArticleActionFeignClient extends FeignProxyClient {
  @GetMapping(value: "/query")
  Future<PageInfo<ArticleActionInfo>> query(FindArticleActionsReq req, [FeignRequestOptions feignOptions]) {
    return this.delegateInvoke<PageInfo<ArticleActionInfo>>("query", [req],
        feignOptions: feignOptions, serializer: PageInfo.serializer);
  }
}

final articleActionFeignClient = ArticleActionFeignClient();
