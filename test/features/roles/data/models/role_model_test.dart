import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/features/roles/data/models/role_model.dart';
import 'package:lomba_frontend/features/roles/domain/entities/role.dart';

void main() {
  const tRoleModel = RoleModel(
    name: 'admin',
    enabled: true,
  );

  const tRole = Role(name: 'admin', enabled: true);

  group('role model methods', () {
    test('role model to entity', () {
      // assert
      final result = tRoleModel.toEntity();
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
        // act
        final result = tRoleModel.toJson();

        // assert
        final expectedJsonMap = {
          'name': 'admin',
          'enabled': true,
        };
        expect(result, equals(expectedJsonMap));
      },
    );
  });
}
