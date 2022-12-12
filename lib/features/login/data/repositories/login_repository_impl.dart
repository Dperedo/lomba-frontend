import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/data/models/session_model.dart';

import '../../../../core/data/datasources/local_data_source.dart';
import '../../../../core/exceptions.dart';
import '../../../../core/failures.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/remote_data_source.dart';

class LoginRepositoryImpl implements LoginRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  LoginRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, bool>> getAuthenticate(
      String username, String password) async {
    try {
      final result = await remoteDataSource.getAuthenticate(username, password);

      SessionModel session = SessionModel(
          token: result.token, username: result.username, name: result.name);

      localDataSource.saveSession(session);

      return const Right(true);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on CacheException {
      return const Left(ConnectionFailure('Failed to write local cache'));
    }
  }
}
