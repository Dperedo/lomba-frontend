import 'package:lomba_frontend/domain/entities/storage/cloudfile.dart';

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
  Future<Either<Failure, CloudFile>> uploadFile(
      Uint8List file, String cloudFileId) async {
    try {
      final result =
          await remoteDataSource.uploadFile(file, cloudFileId);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, CloudFile>> registerCloudFile(String userId, String orgaId) async {
    try {
      final result = await remoteDataSource.registerCloudFile(userId, orgaId);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, CloudFile>> getCloudFile(String cloudFileId) async {
    try {
      final result = await remoteDataSource.getCloudFile(cloudFileId);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, CloudFile>> uploadFileUserProfile(
      String userId, Uint8List file, String cloudFileId) async {
    try {
      final result =
          await remoteDataSource.uploadFileUserProfile(userId, file, cloudFileId);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, List<CloudFile>>> registerCloudFileUserProfile(String userId, String orgaId) async {
    try {
      final result = await remoteDataSource.registerCloudFileUserProfile(userId, orgaId);

      List<CloudFile> list = [];

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
}
