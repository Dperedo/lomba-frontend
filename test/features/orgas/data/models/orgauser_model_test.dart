import 'dart:convert';

import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/features/login/data/models/login_access_model.dart';
import 'package:lomba_frontend/features/login/domain/entities/login_access.dart';
import 'package:lomba_frontend/features/orgas/data/models/orga_model.dart';
import 'package:lomba_frontend/features/orgas/data/models/orgauser_model.dart';
import 'package:lomba_frontend/features/orgas/domain/entities/orgauser.dart';

void main() {
  final newOrgaId = Guid.newGuid.toString();
  final newUserId = Guid.newGuid.toString();

  final tOrgaUserModel = OrgaUserModel(
      orgaId: newOrgaId,
      userId: newUserId,
      roles: const <String>["admin"],
      enabled: true,
      builtIn: false);

  final tOrgaUser = OrgaUser(
      orgaId: newOrgaId,
      userId: newUserId,
      roles: const <String>["admin"],
      enabled: true,
      builtIn: false);

  group('orga user model methods', () {
    test('orga user model to entity', () {
      // assert
      final result = tOrgaUserModel.toEntity();
      expect(result, equals(tOrgaUser));
    });
    test(
      'debe retornar un OrgaUserModel desde un json',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          '{"orgaId":"$newOrgaId", "userId":"$newUserId", "roles": ["admin"], "enabled": true, "builtIn": false}',
        );

        // act
        final result = OrgaUserModel.fromJson(jsonMap);

        // assert
        expect(result, equals(tOrgaUserModel));
      },
    );
    test(
      'debe retornar un json válido desde el orga user model',
      () async {
        // act
        final result = tOrgaUserModel.toJson();

        // assert
        final expectedJsonMap = {
          'orgaId': newOrgaId,
          'userId': newUserId,
          'roles': ["admin"],
          'enabled': true,
          'builtIn': false
        };
        expect(result, equals(expectedJsonMap));
      },
    );
  });
}
