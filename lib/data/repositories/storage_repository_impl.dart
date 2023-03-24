import 'package:lomba_frontend/domain/entities/storage/filecloud.dart';

import 'package:lomba_frontend/core/failures.dart';

import 'package:dartz/dartz.dart';

import 'dart:typed_data';

import '../../core/exceptions.dart';
import '../../domain/repositories/storage_repository.dart';
import '../datasources/storage_data_source.dart';

class StorageRepositoryImpl implements StorageRepository {
  final StorageRemoteDataSource remoteDataSource;

  StorageRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, FileCloud>> uploadFile(
      Uint8List file, String name, String userId, String orgaId) async {
    try {
      final result =
          await remoteDataSource.uploadFile(file, name, userId, orgaId);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }
}
