import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/exceptions.dart';
import 'package:lomba_frontend/core/failures.dart';
import 'package:lomba_frontend/features/login/data/datasources/localcache_data_source.dart';
import 'package:lomba_frontend/features/login/data/datasources/remote_data_source.dart';
import 'package:lomba_frontend/features/login/data/models/token_model.dart';
import 'package:lomba_frontend/features/login/data/repositories/login_repository_impl.dart';
import 'package:lomba_frontend/features/login/domain/entities/token.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'login_repository_impl_test.mocks.dart';

@GenerateMocks([RemoteDataSource, LocalCacheDataSource])
void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalCacheDataSource mockLocalCacheDataSource;
  late LoginRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalCacheDataSource = MockLocalCacheDataSource();
    repository = LoginRepositoryImpl(
      localCacheDataSource: mockLocalCacheDataSource,
      remoteDataSource: mockRemoteDataSource,
    );
  });

  const tTokenModel = TokenModel(id: 'mp', username: 'mp');
  const tToken = Token(id: 'mp', username: 'mp');

  group('get current weather', () {
    final tusername = "mp";
    final tpassword = "ps";

    test(
      'debe retornar el token cuando se obtiene correctamente desde el origen',
      () async {
        // arrange
        when(mockRemoteDataSource.getAuthenticate(tusername, tpassword))
            .thenAnswer((realInvocation) async => tTokenModel);

        // act
        final result = await repository.getAuthenticate(tusername, tpassword);

        // assert
        verify(mockRemoteDataSource.getAuthenticate(tusername, tpassword));
        expect(result, equals(const Right(tToken)));
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
        expect(result, equals(Left(ServerFailure(''))));
      },
    );

    test(
      'debe retornar falla de conexión cuando el dispositivo no tiene internet',
      () async {
        // arrange
        when(mockRemoteDataSource.getAuthenticate(tusername, tpassword))
            .thenThrow(SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getAuthenticate(tusername, tpassword);

        // assert
        verify(mockRemoteDataSource.getAuthenticate(tusername, tpassword));
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });
}
