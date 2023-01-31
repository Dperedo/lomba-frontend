import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/data/models/role_model.dart';
import 'package:lomba_frontend/domain/entities/role.dart';

void main() {
  const tRoleModel = RoleModel(
    name: 'admin',
    enabled: true,
  );

  const tRole = Role(name: 'admin', enabled: true);

  group('role model methods', () {
    test('role model to entity', () {
      //

      //act
      final result = tRoleModel.toEntity();

      //assert
      expect(result, equals(tRole));
    });
    test(
      'debe retornar un RoleModel desde un json',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          '{"name": "admin", "enabled": true}',
        );

        // act
        final result = RoleModel.fromJson(jsonMap);

        // assert
        expect(result, equals(tRoleModel));
      },
    );
    test(
      'debe retornar un json válido desde el role model',
      () async {
        //arrange (preparación)
        final expectedJsonMap = {
          'name': 'admin',
          'enabled': true,
        };

        // act (el acto o el suceso)
        final result = tRoleModel.toJson();

        //assert (comprobaciones)
        expect(result, equals(expectedJsonMap));
      },
    );
  });
}
