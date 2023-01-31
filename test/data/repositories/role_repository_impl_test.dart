import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/exceptions.dart';
import 'package:lomba_frontend/core/failures.dart';
import 'package:lomba_frontend/core/fakedata.dart';
import 'package:lomba_frontend/data/datasources/role_data_source.dart';
import 'package:lomba_frontend/data/models/role_model.dart';
import 'package:lomba_frontend/data/repositories/role_repository_impl.dart';
import 'package:lomba_frontend/domain/entities/role.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'role_repository_impl_test.mocks.dart';

@GenerateMocks([RoleRemoteDataSource])
void main() {
  late MockRoleRemoteDataSource mockRemoteDataSource;
  late RoleRepositoryImpl repository;

  final newRolId = Guid.newGuid.toString();

  const tRolModel = RoleModel(
    name: 'Test Rol',
    enabled: true,
  );

  const tRol = Role(
    name: 'Test Rol',
    enabled: true,
  );

  List<Role> tlistRols = [];

  setUp(() {
    mockRemoteDataSource = MockRoleRemoteDataSource();
    repository = RoleRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );

    for (var element in fakeRoles) {
      tlistRols.add(element.toEntity());
    }
  });
  group('conseguir rol, roles con simulación de problemas', () {
    test(
      'debe retornar un rol',
      () async {
        // arrange
        when(mockRemoteDataSource.getRole(any))
            .thenAnswer((realInvocation) async => tRolModel);

        // act
        final result = await repository.getRole(newRolId);

        // assert
        verify(mockRemoteDataSource.getRole(any)).called(1);
        expect(result, equals(const Right(tRol)));
      },
    );

    test(
      'debe retornar una lista de roles',
      () async {
        // arrange
        when(mockRemoteDataSource.getRoles())
            .thenAnswer((_) async => <RoleModel>[tRolModel]);

        // act
        final result = await repository.getRoles();
        List<Role> list = [];
        result.fold((l) => {}, ((r) => {list = r}));

        // assert
        verify(mockRemoteDataSource.getRoles());
        expect(result.isRight(), true);
        expect(list, (<Role>[tRol]));
      },
    );

    test(
      'debe retornar una server failure cuando el backend de roles falla',
      () async {
        // arrange
        when(mockRemoteDataSource.getRole(any)).thenThrow(ServerException());

        // act
        final result = await repository.getRole(newRolId);

        // assert
        verify(mockRemoteDataSource.getRole(any)).called(1);
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'debe retornar falla de conexión cuando el dispositivo no tiene internet',
      () async {
        // arrange
        when(mockRemoteDataSource.getRole(any)).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getRole(newRolId);

        // assert
        verify(mockRemoteDataSource.getRole(any));
        expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('deshabilitar rol y rolrol con simulación de problemas', () {
    test(
      'debe deshabilitar un rol',
      () async {
        // arrange
        when(mockRemoteDataSource.enableRole(any, any))
            .thenAnswer((realInvocation) async => true);
        when(mockRemoteDataSource.getRole(any))
            .thenAnswer((realInvocation) async => tRolModel);

        // act
        final result = await repository.enableRole(tRolModel.name, false);

        // assert
        verify(mockRemoteDataSource.enableRole(any, any));
        expect(result, equals(const Right(tRol)));
      },
    );

    test(
      'debe retornar una server failure el backend de deshabilitar rol falla',
      () async {
        // arrange
        when(mockRemoteDataSource.enableRole(any, any))
            .thenThrow(ServerException());

        // act
        final result = await repository.enableRole(tRolModel.name, false);

        // assert
        verify(mockRemoteDataSource.enableRole(any, any)).called(1);
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'debe retornar falla de conexión cuando el dispositivo no tiene internet al deshabilitar rol',
      () async {
        // arrange
        when(mockRemoteDataSource.enableRole(any, any)).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.enableRole(tRolModel.name, false);

        // assert
        verify(mockRemoteDataSource.enableRole(any, any));
        expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });
}
