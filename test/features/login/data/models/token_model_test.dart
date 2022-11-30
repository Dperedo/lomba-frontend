import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/features/login/data/models/token_model.dart';
import 'package:lomba_frontend/features/login/domain/entities/token.dart';

void main() {
  const tTokenModel = TokenModel(id: "mp", username: "mp");
  const tToken = Token(id: "mp", username: "mp");

  group('token model methods', () {
    test('token model to entity', () {
      // assert
      final result = tTokenModel.toEntity();
      expect(result, equals(tToken));
    });
    test(
      'debe retornar un TokenModel desde un json',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          '{"id":"mp", "username":"mp"}',
        );

        // act
        final result = TokenModel.fromJson(jsonMap);

        // assert
        expect(result, equals(tTokenModel));
      },
    );
    test(
      'debe retornar un json válido',
      () async {
        // act
        final result = tTokenModel.toJson();

        // assert
        final expectedJsonMap = {'id': 'mp', 'username': 'mp'};
        expect(result, equals(expectedJsonMap));
      },
    );
  });
}
