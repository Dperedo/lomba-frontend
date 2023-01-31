import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/data/datasources/local_data_source.dart';
import 'package:lomba_frontend/data/models/session_model.dart';
import 'package:lomba_frontend/core/exceptions.dart';
import 'package:lomba_frontend/core/failures.dart';
import 'package:lomba_frontend/data/datasources/login_data_source.dart';
import 'package:lomba_frontend/data/models/login_access_model.dart';
import 'package:lomba_frontend/data/repositories/login_repository_impl.dart';
import 'package:lomba_frontend/data/datasources/user_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_repository_impl_test.mocks.dart';

@GenerateMocks([RemoteDataSource, LocalDataSource, UserRemoteDataSource])
void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockUserRemoteDataSource mockUserRemoteDataSource;
  late LoginRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockUserRemoteDataSource = MockUserRemoteDataSource();
    repository = LoginRepositoryImpl(
      localDataSource: mockLocalDataSource,
      remoteDataSource: mockRemoteDataSource,
      userDataSource: mockUserRemoteDataSource,
    );
  });

  const tLoginAccessModel = SessionModel(
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

        // assert
        verify(mockRemoteDataSource.getAuthenticate(tusername, tpassword));
        expect(result, equals(const Left(ServerFailure(''))));
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
              ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });
}
