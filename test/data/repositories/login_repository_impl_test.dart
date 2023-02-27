import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/core/exceptions.dart';
import 'package:lomba_frontend/core/failures.dart';
import 'package:lomba_frontend/data/datasources/local_data_source.dart';
import 'package:lomba_frontend/data/datasources/login_data_source.dart';
import 'package:lomba_frontend/data/datasources/user_data_source.dart';
import 'package:lomba_frontend/data/models/session_model.dart';
import 'package:lomba_frontend/data/models/user_model.dart';
import 'package:lomba_frontend/data/repositories/login_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_repository_impl_test.mocks.dart';

@GenerateMocks([RemoteDataSource, LocalDataSource, UserRemoteDataSource, Guid])
void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockUserRemoteDataSource mockUserRemoteDataSource;
  late LoginRepositoryImpl repository;
  late MockGuid mockGuid;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockUserRemoteDataSource = MockUserRemoteDataSource();
    mockGuid = MockGuid();
    repository = LoginRepositoryImpl(
      localDataSource: mockLocalDataSource,
      remoteDataSource: mockRemoteDataSource,
      userDataSource: mockUserRemoteDataSource,
    );
  });

  final newUserId = Guid.newGuid.toString();

  const tUserModel = UserModel(
      id: '',
      name: 'user',
      username: 'user',
      email: 'user@mp.com',
      enabled: true,
      builtIn: false);

  const tLoginAccessModel = SessionModel(
      token: SystemKeys.tokenSuperAdmin2023,
      username: "mp@mp.com",
      name: "Miguel");

  const tSessionModel = SessionModel(
      token: SystemKeys.tokenSuperAdmin2023,
      username: "mp@mp.com",
      name: "Miguel");

  group('conseguir la autorización con el login repository impl', () {
    const tusername = "mp@mp.com";
    const tpassword = "12345";

    test(
      'debe retornar el token cuando se obtiene correctamente desde el origen',
      () async {
        // arrange
        when(mockLocalDataSource.saveSession(any))
            .thenAnswer((realInvocation) async => true);
        when(mockRemoteDataSource.getAuthenticate(tusername, tpassword))
            .thenAnswer((realInvocation) async => tLoginAccessModel);

        // act
        final result = await repository.getAuthenticate(tusername, tpassword);

        // assert
        verify(mockRemoteDataSource.getAuthenticate(tusername, tpassword));
        verify(mockLocalDataSource.saveSession(any)).called(1);
        expect(result, equals(const Right(tLoginAccessModel)));
      },
    );

    test(
      'debe retornar una server failure cuando la llamada al data source falla',
      () async {
        // arrange
        when(mockRemoteDataSource.getAuthenticate(tusername, tpassword))
            .thenThrow(ServerException());

        // act
        final result = await repository.getAuthenticate(tusername, tpassword);
        Failure? fail;
        // assert
        result.fold((l) => fail = l, (r) => null);

        expect(
            fail,
            equals(const ServerFailure(
                'Ocurrió un error al procesar la solicitud.')));
        verify(mockRemoteDataSource.getAuthenticate(tusername, tpassword));
      },
    );

    test(
      'debe retornar falla de conexión cuando el dispositivo no tiene internet',
      () async {
        // arrange
        when(mockRemoteDataSource.getAuthenticate(tusername, tpassword))
            .thenThrow(
                const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getAuthenticate(tusername, tpassword);

        // assert
        verify(mockRemoteDataSource.getAuthenticate(tusername, tpassword));
        expect(
          result,
          equals(const Left(
              ConnectionFailure('No existe conexión con internet.'))),
        );
      },
    );
  });

  group('registro de usuario en login repository impl', () {
    const tusername = "mp@mp.com";
    const tpassword = "12345";

    test(
      'debe retornar boolean cuando se registra correctamente',
      () async {
        // arrange
        when(mockLocalDataSource.saveSession(any))
            .thenAnswer((realInvocation) async => true);
        when(mockRemoteDataSource.registerUser(
                tUserModel, 'orgaId', '1234', 'user'))
            .thenAnswer((realInvocation) async => true);

        // act
        final result = await repository.registerUser(
            'user', 'user', 'user@mp.com', 'orgaId', '1234', 'user');

        // assert
        verify(mockRemoteDataSource.registerUser(
            tUserModel, 'orgaId', '1234', 'user'));
        expect(result, equals(const Right(true)));
      },
    );

    test(
      'debe retornar una server failure cuando la llamada al data source falla',
      () async {
        // arrange
        when(mockRemoteDataSource.registerUser(
                tUserModel, 'orgaId', '1234', 'user'))
            .thenThrow(ServerException());

        // act
        final result = await repository.registerUser(
            'user', 'user', 'user@mp.com', 'orgaId', '1234', 'user');
        Failure? fail;
        // assert
        result.fold((l) => fail = l, (r) => null);

        expect(
            fail,
            equals(const ServerFailure(
                'Ocurrió un error al procesar la solicitud.')));
        verify(mockRemoteDataSource.registerUser(
            tUserModel, 'orgaId', '1234', 'user'));
      },
    );

    test(
      'debe retornar falla de conexión cuando el dispositivo no tiene internet',
      () async {
        // arrange
        when(mockRemoteDataSource.registerUser(
                tUserModel, 'orgaId', '1234', 'user'))
            .thenThrow(
                const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.registerUser(
            'user', 'user', 'user@mp.com', 'orgaId', '1234', 'user');

        // assert
        verify(mockRemoteDataSource.registerUser(
            tUserModel, 'orgaId', '1234', 'user'));
        expect(
          result,
          equals(const Left(
              ConnectionFailure('No existe conexión con internet.'))),
        );
      },
    );
  });

  group('cambio de organización login repository impl', () {
    const tusername = "mp@mp.com";
    const tpassword = "12345";

    test(
      'debe retornar sessionmodel cuando se cambia correctamente',
      () async {
        // arrange
        when(mockLocalDataSource.saveSession(any))
            .thenAnswer((realInvocation) async => true);
        when(mockRemoteDataSource.changeOrga('user', 'orgaId'))
            .thenAnswer((realInvocation) async => tSessionModel);

        // act
        final result = await repository.changeOrga('user', 'orgaId');

        // assert
        verify(mockRemoteDataSource.changeOrga('user', 'orgaId'));
        expect(result, equals(const Right(tSessionModel)));
      },
    );

    test(
      'debe retornar una server failure cuando la llamada al data source falla',
      () async {
        // arrange
        when(mockRemoteDataSource.changeOrga('user', 'orgaId'))
            .thenThrow(ServerException());

        // act
        final result = await repository.changeOrga('user', 'orgaId');
        Failure? fail;
        // assert
        result.fold((l) => fail = l, (r) => null);

        expect(
            fail,
            equals(const ServerFailure(
                'Ocurrió un error al procesar la solicitud.')));
        verify(mockRemoteDataSource.changeOrga('user', 'orgaId'));
      },
    );

    test(
      'debe retornar falla de conexión cuando el dispositivo no tiene internet',
      () async {
        // arrange
        when(mockRemoteDataSource.changeOrga('user', 'orgaId')).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.changeOrga('user', 'orgaId');

        // assert
        verify(mockRemoteDataSource.changeOrga('user', 'orgaId'));
        expect(
          result,
          equals(const Left(
              ConnectionFailure('No existe conexión con internet.'))),
        );
      },
    );
  });

  group('conseguir la autorización google el login repository impl', () {
    const tusername = "mp@mp.com";
    const tpassword = "12345";

    test(
      'debe retornar el token cuando se obtiene google correctamente desde el origen',
      () async {
        // arrange
        when(mockLocalDataSource.saveSession(any))
            .thenAnswer((realInvocation) async => true);

        when(mockRemoteDataSource.getAuthenticateGoogle(
                tUserModel, 'googletoken'))
            .thenAnswer((realInvocation) async => tLoginAccessModel);

        // act
        final result =
            await repository.getAuthenticateGoogle(tUserModel, 'googletoken');

        // assert
        verify(mockRemoteDataSource.getAuthenticateGoogle(
            tUserModel, 'googletoken'));
        verify(mockLocalDataSource.saveSession(any)).called(1);
        expect(result, equals(const Right(tLoginAccessModel)));
      },
    );

    test(
      'debe retornar una server failure cuando la llamada al data source falla',
      () async {
        // arrange
        when(mockRemoteDataSource.getAuthenticateGoogle(
                tUserModel, 'googletoken'))
            .thenThrow(ServerException());

        // act
        final result =
            await repository.getAuthenticateGoogle(tUserModel, 'googletoken');
        Failure? fail;
        // assert
        result.fold((l) => fail = l, (r) => null);

        expect(
            fail,
            equals(const ServerFailure(
                'Ocurrió un error al procesar la solicitud.')));
        verify(mockRemoteDataSource.getAuthenticateGoogle(
            tUserModel, 'googletoken'));
      },
    );

    test(
      'debe retornar falla de conexión cuando el dispositivo no tiene internet',
      () async {
        // arrange
        when(mockRemoteDataSource.getAuthenticateGoogle(
                tUserModel, 'googletoken'))
            .thenThrow(
                const SocketException('Failed to connect to the network'));

        // act
        final result =
            await repository.getAuthenticateGoogle(tUserModel, 'googletoken');

        // assert
        verify(mockRemoteDataSource.getAuthenticateGoogle(
            tUserModel, 'googletoken'));
        expect(
          result,
          equals(const Left(
              ConnectionFailure('No existe conexión con internet.'))),
        );
      },
    );
  });
}
