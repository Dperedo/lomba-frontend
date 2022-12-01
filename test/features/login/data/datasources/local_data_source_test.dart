import 'dart:convert';

import 'package:lomba_frontend/core/exceptions.dart';
import 'package:lomba_frontend/features/login/data/datasources/local_data_source.dart';
import 'package:lomba_frontend/features/login/data/models/token_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  LoginLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = LoginLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('gestión de token local', () {
    final tokenModel = TokenModel.fromJson(
        json.decode('{"id":"mp@mp.com", "username":"mp@mp.com"}'));

    // arrange
    mockSharedPreferences = MockSharedPreferences();
    dataSource = LoginLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );

    test(
      'debe retornar el token desde el caché',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn('{"id":"mp@mp.com", "username":"mp@mp.com"}');
        // act

        final result = await dataSource.getSavedToken();
        // assert
        verify(mockSharedPreferences.getString(CACHED_TOKEN_KEY));
        expect(result, equals(tokenModel));
      },
    );

    test(
      'debe lanzar CacheException cuando no hay valor en el cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // act
        final call = dataSource.getSavedToken;
        // assert
        expect(() => call(), throwsA(isA<CacheException>()));
      },
    );
  });

  group('gestión del token guardado saveToken', () {
    final tTokenModel = TokenModel(id: "mp@mp.com", username: "mp@mp.com");
    // arrange
    mockSharedPreferences = MockSharedPreferences();
    dataSource = LoginLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
    test(
      'debe usar la SharedPreferences para salvar el token',
      () async {
        //arrange
        when(mockSharedPreferences.setString(any, any))
            .thenAnswer((realInvocation) async => true);
        // act
        dataSource.saveToken(tTokenModel);
        // assert
        final expectedJsonString = json.encode(tTokenModel.toJson());

        verify(mockSharedPreferences.setString(
          CACHED_TOKEN_KEY,
          expectedJsonString,
        )).called(1);
      },
    );
  });
}
