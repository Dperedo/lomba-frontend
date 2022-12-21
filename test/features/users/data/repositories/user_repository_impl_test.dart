import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/exceptions.dart';
import 'package:lomba_frontend/core/failures.dart';
import 'package:lomba_frontend/core/fakedata.dart';
import 'package:lomba_frontend/features/users/data/datasources/user_remote_data_source.dart';
import 'package:lomba_frontend/features/users/data/models/user_model.dart';
import 'package:lomba_frontend/features/users/data/repositories/user_repository_impl.dart';
import 'package:lomba_frontend/features/users/domain/entities/user.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_repository_impl_test.mocks.dart';

@GenerateMocks([UserRemoteDataSource])
void main() {
  late MockUserRemoteDataSource mockRemoteDataSource;
  late UserRepositoryImpl repository;

  final newUserId = Guid.newGuid.toString();

  final tUserModel = UserModel(
      id: newUserId,
      name: 'Test User',
      username: 'test',
      email: 'te@mp.com',
      enabled: true,
      builtIn: false);

  final tUser = User(
      id: newUserId,
      name: 'Test User',
      username: 'test',
      email: 'te@mp.com',
      enabled: true,
      builtIn: false);

  List<User> tlistUsers = [];

  setUp(() {
    mockRemoteDataSource = MockUserRemoteDataSource();
    repository = UserRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );

    for (var element in fakeListUsers) {
      tlistUsers.add(element.toEntity());
    }
  });
  group('conseguir user, users con simulación de problemas', () {
    test(
      'debe retornar un user',
      () async {
        // arrange
        when(mockRemoteDataSource.getUser(any))
            .thenAnswer((realInvocation) async => tUserModel);

        // act
        final result = await repository.getUser(newUserId);

        // assert
        verify(mockRemoteDataSource.getUser(any)).called(1);
        expect(result, equals(Right(tUser)));
      },
    );

    test(
      'debe retornar una lista de users',
      () async {
        // arrange
        when(mockRemoteDataSource.getUsers(any, any, any, any, any))
            .thenAnswer((_) async => <UserModel>[tUserModel]);

        // act
        final result = await repository.getUsers("", "", "", 1, 10);
        List<User> list = [];
        result.fold((l) => {}, ((r) => {list = r}));

        // assert
        verify(mockRemoteDataSource.getUsers(any, any, any, any, any));
        expect(result.isRight(), true);
        expect(list, (<User>[tUser]));
      },
    );

    test(
      'debe retornar una server failure cuando el backend de users falla',
      () async {
        // arrange
        when(mockRemoteDataSource.getUser(any)).thenThrow(ServerException());

        // act
        final result = await repository.getUser(newUserId);

        // assert
        verify(mockRemoteDataSource.getUser(any)).called(1);
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'debe retornar falla de conexión cuando el dispositivo no tiene internet',
      () async {
        // arrange
        when(mockRemoteDataSource.getUser(any)).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getUser(newUserId);

        // assert
        verify(mockRemoteDataSource.getUser(any));
        expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });
  group('agregar user y useruser con simulación de problemas', () {
    test(
      'debe agregar un user',
      () async {
        // arrange
        when(mockRemoteDataSource.addUser(any))
            .thenAnswer((realInvocation) async => tUserModel);

        // act
        final result = await repository.addUser(tUserModel.name,
            tUserModel.username, tUserModel.email, tUserModel.enabled);

        // assert
        verify(mockRemoteDataSource.addUser(any));
        expect(result, equals(Right(tUser)));
      },
    );

    test(
      'debe retornar una server failure el backend de agregar user falla',
      () async {
        // arrange
        when(mockRemoteDataSource.addUser(any)).thenThrow(ServerException());

        // act
        final result = await repository.addUser(tUserModel.name,
            tUserModel.username, tUserModel.email, tUserModel.enabled);

        // assert
        verify(mockRemoteDataSource.addUser(any)).called(1);
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'debe retornar falla de conexión cuando el dispositivo no tiene internet al agregar user',
      () async {
        // arrange
        when(mockRemoteDataSource.addUser(any)).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.addUser(tUserModel.name,
            tUserModel.username, tUserModel.email, tUserModel.enabled);

        // assert
        verify(mockRemoteDataSource.addUser(any));
        expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });
  group('actualizar user y useruser con simulación de problemas', () {
    test(
      'debe actualizar un user',
      () async {
        // arrange
        when(mockRemoteDataSource.updateUser(any, any))
            .thenAnswer((realInvocation) async => tUserModel);

        // act
        final result = await repository.updateUser(tUserModel.id, tUserModel);

        // assert
        verify(mockRemoteDataSource.updateUser(any, any));
        expect(result, equals(Right(tUser)));
      },
    );

    test(
      'debe retornar una server failure el backend de actualizar user falla',
      () async {
        // arrange
        when(mockRemoteDataSource.updateUser(any, any))
            .thenThrow(ServerException());

        // act
        final result = await repository.updateUser(tUserModel.id, tUserModel);

        // assert
        verify(mockRemoteDataSource.updateUser(any, any)).called(1);
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'debe retornar falla de conexión cuando el dispositivo no tiene internet al actualizar user',
      () async {
        // arrange
        when(mockRemoteDataSource.updateUser(any, any)).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.updateUser(tUserModel.id, tUserModel);

        // assert
        verify(mockRemoteDataSource.updateUser(any, any));
        expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });
  group('eliminar user y useruser con simulación de problemas', () {
    test(
      'debe eliminar un user',
      () async {
        // arrange
        when(mockRemoteDataSource.deleteUser(any))
            .thenAnswer((realInvocation) async => true);

        // act
        final result = await repository.deleteUser(tUserModel.id);

        // assert
        verify(mockRemoteDataSource.deleteUser(any));
        expect(result, equals(const Right(true)));
      },
    );

    test(
      'debe retornar una server failure el backend de eliminar user falla',
      () async {
        // arrange
        when(mockRemoteDataSource.deleteUser(any)).thenThrow(ServerException());

        // act
        final result = await repository.deleteUser(tUserModel.id);

        // assert
        verify(mockRemoteDataSource.deleteUser(any)).called(1);
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'debe retornar falla de conexión cuando el dispositivo no tiene internet al eliminar user',
      () async {
        // arrange
        when(mockRemoteDataSource.deleteUser(any)).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.deleteUser(tUserModel.id);

        // assert
        verify(mockRemoteDataSource.deleteUser(any));
        expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });
  group('deshabilitar user y useruser con simulación de problemas', () {
    test(
      'debe deshabilitar un user',
      () async {
        // arrange
        when(mockRemoteDataSource.enableUser(any, any))
            .thenAnswer((realInvocation) async => tUserModel);

        // act
        final result = await repository.enableUser(tUserModel.id, false);

        // assert
        verify(mockRemoteDataSource.enableUser(any, any));
        expect(result, equals(Right(tUser)));
      },
    );

    test(
      'debe retornar una server failure el backend de deshabilitar user falla',
      () async {
        // arrange
        when(mockRemoteDataSource.enableUser(any, any))
            .thenThrow(ServerException());

        // act
        final result = await repository.enableUser(tUserModel.id, false);

        // assert
        verify(mockRemoteDataSource.enableUser(any, any)).called(1);
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'debe retornar falla de conexión cuando el dispositivo no tiene internet al deshabilitar user',
      () async {
        // arrange
        when(mockRemoteDataSource.enableUser(any, any)).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.enableUser(tUserModel.id, false);

        // assert
        verify(mockRemoteDataSource.enableUser(any, any));
        expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });
}
