import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/core/data/datasources/local_data_source.dart';
import 'package:lomba_frontend/core/data/models/session_model.dart';
import 'package:lomba_frontend/core/exceptions.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  LocalDataSource dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = LocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('conseguir información de Session desde el Local Storage', () {
    const jsonSessionString =
        '{"token":"${SystemKeys.tokenSuperAdmin2023}", "username":"mp@mp.com", "name":"Miguel"}';
    final sessionModel = SessionModel.fromJson(json.decode(jsonSessionString));

    // arrange
    mockSharedPreferences = MockSharedPreferences();
    dataSource = LocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );

    test(
      'debe retornar la sessión desde el caché',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(jsonSessionString);
        // act

        final result = await dataSource.getSavedSession();
        // assert
        verify(mockSharedPreferences.getString(CACHED_SESSION_KEY));
        expect(result, equals(sessionModel));
      },
    );

    test(
      'debe lanzar CacheException cuando ocurre un error obteniendo el caché',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // act
        final call = dataSource.getSavedSession;
        // assert
        expect(() => call(), throwsA(isA<CacheException>()));
      },
    );
  });

  group('debe guardar la sessión en el caché local', () {
    const tsessionModel = SessionModel(
        token: SystemKeys.tokenSuperAdmin2023,
        username: "mp@mp.com",
        name: "Miguel");

    // arrange
    mockSharedPreferences = MockSharedPreferences();
    dataSource = LocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
    test(
      'guardar la session en la Storage local',
      () async {
        //arrange
        when(mockSharedPreferences.setString(any, any))
            .thenAnswer((realInvocation) async => true);
        // act
        dataSource.saveSession(tsessionModel);
        // assert
        final expectedJsonString = json.encode(tsessionModel.toJson());

        verify(mockSharedPreferences.setString(
          CACHED_SESSION_KEY,
          expectedJsonString,
        )).called(1);
      },
    );
  });

  group('consulta si session existe en el local', () {
    const tsessionModel = SessionModel(
        token: SystemKeys.tokenSuperAdmin2023,
        username: "mp@mp.com",
        name: "Miguel");
    // arrange
    mockSharedPreferences = MockSharedPreferences();
    dataSource = LocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
    test(
      'session existe como clave en el caché local',
      () async {
        //arrange
        when(mockSharedPreferences.containsKey(any)).thenAnswer((_) => true);
        // act
        final hasToken = await dataSource.hasSession();
        // assert
        verify(mockSharedPreferences.containsKey(CACHED_SESSION_KEY)).called(1);
        expect(true, equals(hasToken));
      },
    );

    test(
      'session no existe como clave en el caché local',
      () async {
        //arrange
        when(mockSharedPreferences.containsKey(any)).thenAnswer((_) => false);
        // act
        final hasToken = await dataSource.hasSession();
        // assert
        verify(mockSharedPreferences.containsKey(CACHED_SESSION_KEY)).called(1);
        expect(false, equals(hasToken));
      },
    );
  });
}
