import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../core/exceptions.dart';
import '../../domain/entities/setting.dart';
import '../../domain/repositories/setting_repository.dart';
import '../datasources/setting_data_source.dart';

class SettingRepositoryImpl implements SettingRepository {
  final SettingRemoteDataSource remoteDataSource;

  SettingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Setting>>> getSettingSuper() async {
    try {
      final result = await remoteDataSource.getSettingSuper();

      List<Setting> list = [];

      if (result.isNotEmpty) {
        for (var element in result) {
          list.add(element.toEntity());
        }
      }

      return Right(list);
    } on ServerException {
      return const Left(ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, List<Setting>>> getSettingAdmin(String orgaId) async {
    try {
      final result = await remoteDataSource.getSettingAdmin(orgaId);

      List<Setting> list = [];

      if (result.isNotEmpty) {
        for (var element in result) {
          list.add(element.toEntity());
        }
      }

      return Right(list);
    } on ServerException {
      return const Left(ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, bool>> updatedSettingSuper(
      String id,String value) async {
    try {
      final result =
          await remoteDataSource.updatedSettingSuper(id, value);

      return Right(result);
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, bool>> updatedSettingAdmin(
      String id,String value,String orgaId) async {
    try {
      final result =
          await remoteDataSource.updatedSettingAdmin(id, value, orgaId);

      return Right(result);
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  
}
