import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/data/datasources/role_data_source.dart';

import '../../core/exceptions.dart';
import '../../core/failures.dart';
import '../../domain/entities/role.dart';
import '../../domain/repositories/role_repository.dart';

class RoleRepositoryImpl implements RoleRepository {
  final RoleRemoteDataSource remoteDataSource;

  RoleRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Role>>> getRoles() async {
    try {
      final result = await remoteDataSource.getRoles();

      List<Role> list = [];

      if (result.isNotEmpty) {
        for (var element in result) {
          list.add(element.toEntity());
        }
      }

      return Right(list);
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, Role>> getRole(String name) async {
    try {
      final result = await remoteDataSource.getRole(name);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, Role>> enableRole(
      String name, bool enableOrDisable) async {
    try {
      final result = await remoteDataSource.enableRole(name, enableOrDisable);
      if (result) {
        final resultItem = await remoteDataSource.getRole(name);
        return Right(resultItem.toEntity());
      }
      return const Left(ServerFailure('No fue posible realizar la acción'));
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }
}
