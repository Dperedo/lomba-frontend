import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/core/data/models/session_model.dart';
import 'package:lomba_frontend/core/domain/entities/session.dart';

void main() {
  const tSessionModel = SessionModel(
      token: SystemKeys.tokenSuperAdmin2023,
      username: "mp@mp.com",
      name: "Miguel");
  const tSession = Session(
      token: SystemKeys.tokenSuperAdmin2023,
      username: "mp@mp.com",
      name: "Miguel");

  group('métodos del Session Model', () {
    const jsonSessionString =
        '{"token":"${SystemKeys.tokenSuperAdmin2023}", "username":"mp@mp.com", "name":"Miguel"}';
    test('session model a entidad', () {
      // assert
      final result = tSessionModel.toEntity();
      expect(result, equals(tSession));
    });
    test(
      'debe retornar un SessionModel desde un json',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          jsonSessionString,
        );

        // act
        final result = SessionModel.fromJson(jsonMap);

        // assert
        expect(result, equals(tSessionModel));
      },
    );
    test(
      'debe retornar un json válido',
      () async {
        // act
        final result = tSessionModel.toJson();

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
