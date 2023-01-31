import 'dart:convert';

import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/data/models/orga_model.dart';
import 'package:lomba_frontend/domain/entities/orga.dart';

void main() {
  final newOrgaId = Guid.newGuid.toString();

  final tOrgaModel = OrgaModel(
      id: newOrgaId,
      name: 'Test Orga',
      code: 'test',
      enabled: true,
      builtIn: false);

  final tOrga = Orga(
      id: newOrgaId,
      name: 'Test Orga',
      code: 'test',
      enabled: true,
      builtIn: false);

  group('orga model methods', () {
    test('orga model to entity', () {
      // assert
      final result = tOrgaModel.toEntity();
      expect(result, equals(tOrga));
    });
    test(
      'debe retornar un OrgaModel desde un json',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          '{"id":"$newOrgaId", "name":"Test Orga", "code": "test", "enabled": true, "builtIn": false}',
        );

        // act
        final result = OrgaModel.fromJson(jsonMap);

        // assert
        expect(result, equals(tOrgaModel));
      },
    );
    test(
      'debe retornar un json válido desde el orga model',
      () async {
        // act
        final result = tOrgaModel.toJson();

        // assert
        final expectedJsonMap = {
          'id': newOrgaId,
          'name': 'Test Orga',
          'code': 'test',
          'enabled': true,
          'builtIn': false
        };
        expect(result, equals(expectedJsonMap));
      },
    );
  });
}
