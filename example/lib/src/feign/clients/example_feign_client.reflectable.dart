// This file has been generated by the reflectable package.
// https://github.com/dart-lang/reflectable.

import 'dart:core';
import 'example_feign_client.dart' as prefix1;
import 'package:fengwuxp_dart_openfeign/src/annotations/feign_client.dart'
    as prefix0;
import 'package:fengwuxp_dart_openfeign/src/annotations/request_mapping.dart'
    as prefix2;

// ignore_for_file: prefer_adjacent_string_concatenation
// ignore_for_file: prefer_collection_literals
// ignore_for_file: unnecessary_const
// ignore_for_file: implementation_imports

// ignore:unused_import
import 'package:reflectable/mirrors.dart' as m;
// ignore:unused_import
import 'package:reflectable/src/reflectable_builder_based.dart' as r;
// ignore:unused_import
import 'package:reflectable/reflectable.dart' as r show Reflectable;

final _data = <r.Reflectable, r.ReflectorData>{
  const prefix0.FeignClient(): r.ReflectorData(
      <m.TypeMirror>[
        r.NonGenericClassMirrorImpl(
            r'ExampleFeignClient',
            r'.ExampleFeignClient',
            7,
            0,
            const prefix0.FeignClient(),
            const <int>[0, 1, 2, 3, 4],
            const <int>[5, 6, 7, 8, 9, 10, 0, 1, 2, 3],
            const <int>[],
            -1,
            {},
            {},
            {r'': (b) => () => b ? prefix1.ExampleFeignClient() : null},
            -1,
            0,
            const <int>[],
            const <Object>[const prefix0.FeignClient(value: '/example_cms')],
            null)
      ],
      <m.DeclarationMirror>[
        r.MethodMirrorImpl(
            r'getNums',
            4325378,
            0,
            -1,
            -1,
            -1,
            null,
            const <int>[0, 1],
            const prefix0.FeignClient(),
            const <Object>[const prefix2.GetMapping(value: 'get_num')]),
        r.MethodMirrorImpl(
            r'getMaps',
            4325378,
            0,
            -1,
            -1,
            -1,
            null,
            const <int>[2, 3],
            const prefix0.FeignClient(),
            const <Object>[const prefix2.GetMapping(value: 'get_maps')]),
        r.MethodMirrorImpl(
            r'getMap',
            4325378,
            0,
            -1,
            -1,
            -1,
            null,
            const <int>[4],
            const prefix0.FeignClient(),
            const <Object>[const prefix2.GetMapping(value: 'get_map')]),
        r.MethodMirrorImpl(
            r'getMap2',
            4325378,
            0,
            -1,
            -1,
            -1,
            null,
            const <int>[5],
            const prefix0.FeignClient(),
            const <Object>[const prefix2.GetMapping(value: 'get_map_2')]),
        r.MethodMirrorImpl(r'', 0, 0, -1, -1, -1, null, const <int>[],
            const prefix0.FeignClient(), const []),
        r.MethodMirrorImpl(r'==', 131074, null, -1, -1, -1, null,
            const <int>[6], const prefix0.FeignClient(), const []),
        r.MethodMirrorImpl(r'toString', 131074, null, -1, -1, -1, null,
            const <int>[], const prefix0.FeignClient(), const []),
        r.MethodMirrorImpl(
            r'noSuchMethod',
            4325378,
            null,
            -1,
            -1,
            -1,
            null,
            const <int>[7],
            const prefix0.FeignClient(),
            const <Object>[override]),
        r.MethodMirrorImpl(r'hashCode', 131075, null, -1, -1, -1, null,
            const <int>[], const prefix0.FeignClient(), const []),
        r.MethodMirrorImpl(r'runtimeType', 131075, null, -1, -1, -1, null,
            const <int>[], const prefix0.FeignClient(), const []),
        r.MethodMirrorImpl(r'delegateInvoke', 4325378, null, -1, -1, -1, null,
            const <int>[8, 9, 10, 11], const prefix0.FeignClient(), const [])
      ],
      <m.ParameterMirror>[
        r.ParameterMirrorImpl(r'num', 32774, 0, const prefix0.FeignClient(), -1,
            -1, -1, null, const [], null, null),
        r.ParameterMirrorImpl(
            r'feignOptions',
            36870,
            0,
            const prefix0.FeignClient(),
            -1,
            -1,
            -1,
            null,
            const [],
            null,
            null),
        r.ParameterMirrorImpl(r'num', 32774, 1, const prefix0.FeignClient(), -1,
            -1, -1, null, const [], null, null),
        r.ParameterMirrorImpl(
            r'feignOptions',
            36870,
            1,
            const prefix0.FeignClient(),
            -1,
            -1,
            -1,
            null,
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'feignOptions',
            36870,
            2,
            const prefix0.FeignClient(),
            -1,
            -1,
            -1,
            null,
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'feignOptions',
            36870,
            3,
            const prefix0.FeignClient(),
            -1,
            -1,
            -1,
            null,
            const [],
            null,
            null),
        r.ParameterMirrorImpl(r'other', 16390, 5, const prefix0.FeignClient(),
            null, -1, -1, null, const [], null, null),
        r.ParameterMirrorImpl(
            r'invocation',
            32774,
            7,
            const prefix0.FeignClient(),
            -1,
            -1,
            -1,
            null,
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'methodName',
            32774,
            10,
            const prefix0.FeignClient(),
            -1,
            -1,
            -1,
            null,
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'positionalArguments',
            2129926,
            10,
            const prefix0.FeignClient(),
            -1,
            -1,
            -1,
            null,
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'feignOptions',
            45062,
            10,
            const prefix0.FeignClient(),
            -1,
            -1,
            -1,
            null,
            const [],
            null,
            #feignOptions),
        r.ParameterMirrorImpl(
            r'serializer',
            2142214,
            10,
            const prefix0.FeignClient(),
            -1,
            -1,
            -1,
            null,
            const [],
            null,
            #serializer)
      ],
      <Type>[prefix1.ExampleFeignClient],
      1,
      {
        r'==': (dynamic instance) => (x) => instance == x,
        r'toString': (dynamic instance) => instance.toString,
        r'noSuchMethod': (dynamic instance) => instance.noSuchMethod,
        r'hashCode': (dynamic instance) => instance.hashCode,
        r'runtimeType': (dynamic instance) => instance.runtimeType,
        r'delegateInvoke': (dynamic instance) => instance.delegateInvoke,
        r'getNums': (dynamic instance) => instance.getNums,
        r'getMaps': (dynamic instance) => instance.getMaps,
        r'getMap': (dynamic instance) => instance.getMap,
        r'getMap2': (dynamic instance) => instance.getMap2
      },
      {},
      null,
      [])
};

final _memberSymbolMap = null;

void initializeReflectable() {
  r.data = _data;
  r.memberSymbolMap = _memberSymbolMap;
}
