import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/data/models/workflow/flow_model.dart';
import 'package:lomba_frontend/domain/entities/workflow/flow.dart';
import 'package:lomba_frontend/domain/entities/workflow/stage.dart';

void main() {
  final testStage = Stage(
    id: '1',
    name: 'Carga',
    order: 1,
    queryOut: null,
    enabled: true,
    builtIn: true,
    created: DateTime.parse('2023-02-17T19:16:06.648Z'),
    updated: null,
    deleted: null,
    expires: null
    );

  //final tStage = List<Stage> [testStage];

  final tFlowModel = FlowModel(
    id: '1',
    name: 'flow1',
    enabled: true,
    builtIn: true,
    created: DateTime.parse('2023-02-17 19:16:08.700Z'),
    stages: <Stage>[],
    updated: null,
    deleted: null,
    expires: null
  );

  final tFlow = Flow(
    id: '1',
    name: 'flow1',
    enabled: true,
    builtIn: true,
    created: DateTime.parse('2023-02-17 19:16:08.700Z'),
    stages: [],
    updated: null,
    deleted: null,
    expires: null
  );

  group('flow model methods', () {
    test('flow model to entity', () {
      //

      //act
      final result = tFlowModel.toEntity();

      //assert
      expect(result, equals(tFlow));
    });
    test(
      'debe retornar un FlowModel desde un json',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          '{"id": "1","name": "flow1","enabled": true,"builtIn": true,"created": "2023-02-17 19:16:08.700Z","stages": [],"updated": null,"deleted": null,"expires": null}',
        );

        // act
        final result = FlowModel.fromJson(jsonMap);

        // assert
        expect(result, equals(tFlowModel));
      },
    );
    test(
      'debe retornar un json válido desde el flow model',
      () async {
        //arrange (preparación)
        final expectedJsonMap = {
          'id': '1',
          'name': 'flow1',
          'enabled': true,
          'builtIn': true,
          'created': DateTime.parse('2023-02-17 19:16:08.700Z'),
          'stages': [],
          'updated': null,
          'deleted': null,
          'expires': null
        };

        // act (el acto o el suceso)
        final result = tFlowModel.toJson();

        //assert (comprobaciones)
        expect(result, equals(expectedJsonMap));
      },
    );
  });
}
/*
final expectedJsonMap = {
          'id': '1',
          'name': 'flow1',
          'enabled': true,
          'builtIn': true,
          'created': '2023-02-17 19:16:08.700Z',
          'stages': [{"name":"Carga","order":1,"queryOut":null,"_id":"1","id":"1","enabled":true,"builtIn":true,"created":"2023-02-17T19:16:06.648Z"}],
          'updated': null,
          'deleted': null,
          'expires': null
        };
*/
