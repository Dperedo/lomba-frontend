import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/data/models/workflow/flow_model.dart';
import 'package:lomba_frontend/data/models/workflow/stage_model.dart';
import 'package:lomba_frontend/domain/entities/workflow/flow.dart';
import 'package:lomba_frontend/domain/entities/workflow/stage.dart';

void main() {
  final tStage = Stage(
    id: '1',
    name: 'Aprobación',
    order: 2,
    queryOut: null,
    enabled: true,
    builtIn: true,
    created: DateTime.parse('2023-02-17 19:16:08.700Z'),
    updated: null,
    deleted: null,
    expires: null
    );

  //final tStage = List<Stage> [testStage];

  final tStageModel = StageModel(
    id: '1',
    name: 'Aprobación',
    order: 2,
    queryOut: null,
    enabled: true,
    builtIn: true,
    created: DateTime.parse('2023-02-17 19:16:08.700Z'),
    updated: null,
    deleted: null,
    expires: null
  );

  group('stage model methods', () {
    test('stage model to entity', () {
      //

      //act
      final result = tStageModel.toEntity();

      //assert
      expect(result, equals(tStage));
    });
    test(
      'debe retornar un StageModel desde un json',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          '{ "id": "1", "name": "Aprobación", "order": 2, "queryOut": null, "enabled": true, "builtIn": true, "created": "2023-02-17 19:16:08.700Z", "updated": null, "deleted": null, "expires": null }',
        );

        // act
        final result = StageModel.fromJson(jsonMap);

        // assert
        expect(result, equals(tStageModel));
      },
    );
    test(
      'debe retornar un json válido desde el stage model',
      () async {
        //arrange (preparación)
        final expectedJsonMap = {
          'id': '1',
          'name': 'Aprobación',
          'order': 2,
          'queryOut': null,
          'enabled': true,
          'builtIn': true,
          'created': DateTime.parse('2023-02-17 19:16:08.700Z'),
          'updated': null,
          'deleted': null,
          'expires': null
        };

        // act (el acto o el suceso)
        final result = tStageModel.toJson();

        //assert (comprobaciones)
        expect(result, equals(expectedJsonMap));
      },
    );
  });
}
