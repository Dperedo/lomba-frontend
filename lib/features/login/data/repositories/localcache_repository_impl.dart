import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/validators.dart';

import '../../../../core/exceptions.dart';
import '../../../../core/failures.dart';
import '../../domain/repositories/localcache_repository.dart';
import '../datasources/localcache_data_source.dart';

class LocalCacheRepositoryImpl implements LocalCacheRepository {
  final LocalCacheDataSource localDataSource;

  LocalCacheRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, bool>> validateLogin() async {
    try {
      if (!await localDataSource.hasToken()) {
        return Future.value(const Right(false));
      }

      final tokenModel = await localDataSource.getSavedToken();

      if (!Validators.validateToken(tokenModel.id)) {
        return Future.value(const Right(false));
      }
      return const Right(true);
    } on CacheException {
      return const Left(ConnectionFailure('Failed to read local cache'));
    }
  }
}
