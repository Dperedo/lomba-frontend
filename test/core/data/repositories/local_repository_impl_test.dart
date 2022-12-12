import 'dart:ffi';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/core/data/datasources/local_data_source.dart';
import 'package:lomba_frontend/core/data/models/session_model.dart';
import 'package:lomba_frontend/core/data/repositories/local_repository_impl.dart';
import 'package:lomba_frontend/core/domain/entities/session.dart';
import 'package:lomba_frontend/core/exceptions.dart';
import 'package:lomba_frontend/core/failures.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'local_repository_impl_test.mocks.dart';

@GenerateMocks([LocalDataSource])
void main() {
  late MockLocalDataSource mockLocalDataSource;
  late LocalRepositoryImpl repository;

  final tusername = "mp@mp.com";
  final tpassword = "12345";

  const tSessionModel = SessionModel(
      token: SystemKeys.tokenSuperAdmin2023,
      username: 'mp@mp.com',
      name: 'Miguel');
  const tSession = Session(
      token: SystemKeys.tokenSuperAdmin2023,
      username: 'mp@mp.com',
      name: 'Miguel');

  const tEmptySessionModel = SessionModel(token: "", username: "", name: "");
  const tInvalidTokenSessionModel = SessionModel(
      token: SystemKeys.tokenExpiredSuperAdmin,
      username: 'mp@mp.com',
      name: 'Miguel');

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    repository = LocalRepositoryImpl(localDataSource: mockLocalDataSource);
  });

  group('debe obtener datos del caché local', () {
    test('debe obtener session creada', () async {
      //arrange
      when(mockLocalDataSource.hasSession())
          .thenAnswer((realInvocation) async => true);
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => tSessionModel);

      //act
      final result = await repository.getSession();

      //assert
      verify(mockLocalDataSource.getSavedSession()).called(1);
      expect(result, const Right(tSessionModel));
    });

    test('debe obtener session vacía (sin sessión)', () async {
      //arrange
      when(mockLocalDataSource.hasSession())
          .thenAnswer((realInvocation) async => false);

      //act
      final result = await repository.getSession();

      //assert
      verify(mockLocalDataSource.hasSession()).called(1);
      expect(result, const Right(tEmptySessionModel));
    });

    test('debe obtener session vacía cuando token es inválido', () async {
      //arrange
      when(mockLocalDataSource.hasSession())
          .thenAnswer((realInvocation) async => true);

      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => tInvalidTokenSessionModel);

      //act
      final result = await repository.getSession();

      //assert
      verify(mockLocalDataSource.getSavedSession()).called(1);
      expect(result, const Right(tEmptySessionModel));
    });

    test(
      'debe retornar falla de conexión cuando no accede a caché local',
      () async {
        // arrange
        when(mockLocalDataSource.hasSession())
            .thenAnswer((realInvocation) async => true);
        when(mockLocalDataSource.getSavedSession()).thenThrow(CacheException());

        // act
        final result = await repository.getSession();

        // assert
        verify(mockLocalDataSource.getSavedSession()).called(1);

        expect(
          result,
          equals(const Left(ConnectionFailure('Failed to read local cache'))),
        );
      },
    );
  });
  group('debe guardar datos en el caché local', () {
    test(
      'debe guardar la session enviada',
      () async {
        // arrange
        when(mockLocalDataSource.saveSession(tSessionModel))
            .thenAnswer((realInvocation) async => true);

        // act
        final result = await repository.saveSession(tSessionModel);

        // assert
        verify(mockLocalDataSource.saveSession(tSessionModel)).called(1);
        expect(result, equals(const Right(true)));
      },
    );

    test(
      'debe retornar connection failure si no guarda la sessión',
      () async {
        // arrange
        when(mockLocalDataSource.saveSession(tSessionModel))
            .thenThrow(CacheException());

        // act
        final result = await repository.saveSession(tSessionModel);

        // assert
        verify(mockLocalDataSource.saveSession(tSessionModel)).called(1);
        expect(
          result,
          equals(const Left(ConnectionFailure('Failed to write local cache'))),
        );
      },
    );

    test(
      'debe entregar el rol según el token',
      () async {
        //arrange
        when(mockLocalDataSource.hasSession())
            .thenAnswer((realInvocation) async => true);
        when(mockLocalDataSource.getSavedSession())
            .thenAnswer((realInvocation) async => tSessionModel);

        // act
        final result = await repository.getSessionRole();

        // assert
        verify(mockLocalDataSource.getSavedSession()).called(1);

        expect(result, equals(const Right("superadmin")));
      },
    );

    test(
      'debe entregar el rol anónimo si el token no es válido',
      () async {
        //arrange
        when(mockLocalDataSource.hasSession())
            .thenAnswer((realInvocation) async => true);
        when(mockLocalDataSource.getSavedSession())
            .thenAnswer((realInvocation) async => tInvalidTokenSessionModel);

        // act
        final result = await repository.getSessionRole();

        // assert
        verify(mockLocalDataSource.getSavedSession()).called(1);

        expect(result, equals(const Right("anonymous")));
      },
    );

    test(
      'debe entregar la lista de opciones de menu para superadmin',
      () async {
        //arrange
        when(mockLocalDataSource.hasSession())
            .thenAnswer((realInvocation) async => true);
        when(mockLocalDataSource.getSavedSession())
            .thenAnswer((realInvocation) async => tSessionModel);

        const listExpected = <String>[
          "home",
          "logoff",
          "profile",
          "orgas",
          "users",
          "roles"
        ];

        // act
        final result = await repository.getSideMenuListOptions();

        // assert
        verify(mockLocalDataSource.getSavedSession()).called(1);

        expect(result.length(), equals(const Right(listExpected).length()));
      },
    );

    test(
      'debe entregar la lista de opciones de menu para session no válida',
      () async {
        //arrange
        when(mockLocalDataSource.hasSession())
            .thenAnswer((realInvocation) async => true);
        when(mockLocalDataSource.getSavedSession())
            .thenAnswer((realInvocation) async => tInvalidTokenSessionModel);
        const listExpected = <String>["home", "login"];

        // act
        final result = await repository.getSideMenuListOptions();

        // assert
        verify(mockLocalDataSource.getSavedSession()).called(1);

        expect(result.length(),
            equals(const Right(<String>["home", "login"]).length()));
      },
    );

    test(
      'debe responser si la session es válida',
      () async {
        //arrange
        when(mockLocalDataSource.hasSession())
            .thenAnswer((realInvocation) async => true);
        when(mockLocalDataSource.getSavedSession())
            .thenAnswer((realInvocation) async => tSessionModel);

        // act
        final result = await repository.hasLogIn();

        // assert
        verify(mockLocalDataSource.getSavedSession()).called(1);

        expect(result, equals(const Right(true)));
      },
    );

    test(
      'debe responder que la session no es válida',
      () async {
        //arrange
        when(mockLocalDataSource.hasSession()).thenAnswer((_) async => true);
        when(mockLocalDataSource.getSavedSession())
            .thenAnswer((_) async => tInvalidTokenSessionModel);

        // act
        final result = await repository.hasLogIn();

        // assert
        verify(mockLocalDataSource.getSavedSession()).called(1);

        expect(result, equals(const Right(false)));
      },
    );
  });
}
