import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/features/login/data/datasources/localcache_data_source.dart';
import 'package:lomba_frontend/features/login/domain/entities/token.dart';

import '../../../../core/exceptions.dart';
import '../../../../core/failures.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/remote_data_source.dart';
import '../models/token_model.dart';

class LoginRepositoryImpl implements LoginRepository {
  final RemoteDataSource remoteDataSource;
  final LocalCacheDataSource localCacheDataSource;

  LoginRepositoryImpl(
      {required this.remoteDataSource, required this.localCacheDataSource});

  @override
  Future<Either<Failure, Token>> getAuthenticate(
      String username, String password) async {
    try {
      final result = await remoteDataSource.getAuthenticate(username, password);

      localCacheDataSource.saveToken(result);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on CacheException {
      return const Left(ConnectionFailure('Failed to write local cache'));
    }
  }
}
