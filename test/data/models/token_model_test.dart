import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/data/models/login_access_model.dart';
import 'package:lomba_frontend/domain/entities/login_access.dart';

void main() {
  const tLoginAccessModel = LoginAccessModel(
      token: SystemKeys.tokenSuperAdmin2023,
      username: "mp@mp.com",
      name: "Miguel");
  const tLoginAccess = LoginAccess(
      token: SystemKeys.tokenSuperAdmin2023,
      username: "mp@mp.com",
      name: "Miguel");

  group('login access model methods', () {
    test('login access model to entity', () {
      // assert
      final result = tLoginAccessModel.toEntity();
      expect(result, equals(tLoginAccess));
    });
    test(
      'debe retornar un LoginAccessModel desde un json',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          '{"token":"${SystemKeys.tokenSuperAdmin2023}", "username":"mp@mp.com", "name": "Miguel"}',
        );

        // act
        final result = LoginAccessModel.fromJson(jsonMap);

        // assert
        expect(result, equals(tLoginAccessModel));
      },
    );
    test(
      'debe retornar un json válido',
      () async {
        // act
        final result = tLoginAccessModel.toJson();

        // assert
        final expectedJsonMap = {
          'token': SystemKeys.tokenSuperAdmin2023,
          'username': 'mp@mp.com',
          'name': 'Miguel'
        };
        expect(result, equals(expectedJsonMap));
      },
    );
  });
}
