import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../core/exceptions.dart';
import '../../domain/entities/storage/externaluri.dart';
import '../../domain/repositories/externaluri_repository.dart';
import '../datasources/externaluri_data_source.dart';

class ExternalUriRepositoryImpl implements ExternalUriRepository {
  final ExternalUriRemoteDataSource remoteDataSource;

  ExternalUriRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ExternalUri>> postExternalUri(
      String userId, String uri) async {
    try {
      final result =
          await remoteDataSource.postExternalUri(userId, uri);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, ExternalUri>> getExternalUriById(
      String uriId) async {
    try {
      final result = await remoteDataSource.getExternalUriById(uriId);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, ExternalUri>> getExternalUriByUri(
      String uri) async {
    try {
      final result = await remoteDataSource.getExternalUriByUri(uri);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

}
