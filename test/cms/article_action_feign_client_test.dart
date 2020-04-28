import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:fengwuxp_dart_basic/index.dart';
import 'package:fengwuxp_dart_openfeign/src/configuration/feign_configuration_registry.dart';
import 'package:fengwuxp_dart_openfeign/src/http/response_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../built/serializers.dart';
import '../feign/mock_feign_configuration.dart';
import 'article_action_feign_client.dart';
import 'article_action_feign_client_test.reflectable.dart';
import 'info/article_action_info.dart';
import 'info/page_article_action_info.dart';
import 'req/find_article_actions_req.dart';
import 'resp/page_info.dart';

void main() {
  initializeReflectable();

  test("test article action feign client", () async {
    registryFeignConfiguration(MockFeignConfiguration());
    await articleActionFeignClient
        .query(FindArticleActionsReq((b) => b
          ..articleId = 1
          ..sourceCode = "2"))
        .then((data) {
      print("$data");
    }).catchError((error) {
      if (error is ResponseEntity) {
        print("===>${error.body["message"]}");
      } else {
        print("===>${error}");
      }
    });

//    Future.error(1).catchError((data){
//      print("==$data==>");
//    });
  });

  test("test generic type serizable ", () {
    var articleActions = PageInfo<ArticleActionInfo>((b) {
      var builder = b
        ..total = 1
        ..queryPage = 1
        ..querySize = 10
        ..queryType = "QUERY_RESULT";
      builder.records = ListBuilder<ArticleActionInfo>([
        ArticleActionInfo((ab) => ab
          ..id = 1
          ..sourceCode = "2"
          ..articleId = 1
          ..actionType = "1"
          ..crateTime = DateTime.utc(2020, 04, 27, 11, 22, 33, 44))
      ]);
      return builder;
    });
    var specifiedType = FullType(PageInfo, [FullType(ArticleActionInfo)]);
    var serializer = PageInfo.serializer;
    var builtJsonSerializers = new BuiltJsonSerializers(serializers);
    var result1 =
        builtJsonSerializers.toJson(articleActions, serializer: PageInfo.serializer, specifiedType: specifiedType);
    print("==result1==>$result1");
    var result2 =
        (serializer as StructuredSerializer).serialize(serializers, articleActions, specifiedType: specifiedType);
    print("====>$result2");
    var result3 = articleActions.toJson();
    print("====>$result3");

    var jsonText = '''
    {
  "total": 1,
  "records": [
    {
      "id": 1,
      "articleId": 1,
      "actionType": "1",
      "sourceCode": "2",
      "crateTime": 1587986553044000
    }
  ],
  "querySize": 10,
  "queryPage": 1,
  "queryType": "QUERY_RESULT"
}
    
    ''';
    var result4 =
        builtJsonSerializers.parseObject(jsonText, serializer: PageInfo.serializer, specifiedType: specifiedType);
    print("==result4==>$result4");
    var result5 = builtJsonSerializers.parseObject(jsonText, serializer: PageArticleActionInfo.serializer);
    print("==去泛型 result5==>$result5");

    var jsonText2 = '''
    {
  "total": 1,
  "records": [
    {
      "id": 1,
      "sourceCode": "2"
    }
  ],
  "querySize": 10,
  "queryPage": 1,
  "queryType": "QUERY_RESULT"
}
    
    ''';
    var result6 = builtJsonSerializers.parseObject(jsonText2,
        serializer: PageInfo.serializer, specifiedType: FullType(PageInfo, [FullType(FindArticleActionsReq)]));
    print("==result6==>$result6");
  });
}