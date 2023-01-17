import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:lomba_frontend/features/users/data/datasources/user_remote_data_source.dart';
import 'package:lomba_frontend/features/users/data/models/user_model.dart';

import '../../../../core/exceptions.dart';
import '../../../../core/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<User>>> getUsers(String orgaId, String filter,
      String fieldOrder, double pageNumber, int pageSize) async {
    try {
      if (orgaId == "") {
        orgaId = '00000200-0200-0200-0200-000000000200';
      } // DEFAULT

      final result = await remoteDataSource.getUsers(
          orgaId, filter, fieldOrder, pageNumber, pageSize);

      List<User> list = [];

      if (result.isNotEmpty) {
        for (var element in result) {
          list.add(element.toEntity());
        }
      }

      return Right(list);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, User>> getUser(String userId) async {
    try {
      final result = await remoteDataSource.getUser(userId);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, User>> addUser(
      String name, String username, String email, bool enabled) async {
    try {
      UserModel userModel = UserModel(
          id: Guid.newGuid.toString(),
          name: name,
          username: username,
          email: email,
          enabled: enabled,
          builtIn: false);

      final result = await remoteDataSource.addUser(userModel);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteUser(String userId) async {
    try {
      final result = await remoteDataSource.deleteUser(userId);

      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, User>> enableUser(
      String userId, bool enableOrDisable) async {
    try {
      final result = await remoteDataSource.enableUser(userId, enableOrDisable);
      if (result) {
        final resultItem = await remoteDataSource.getUser(userId);
        return Right(resultItem.toEntity());
      }
      return const Left(ServerFailure(''));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, User>> updateUser(String userId, User user) async {
    try {
      UserModel userModel = UserModel(
          id: userId,
          name: user.name,
          username: user.username,
          email: user.email,
          enabled: user.enabled,
          builtIn: user.builtIn);

      final result = await remoteDataSource.updateUser(userId, userModel);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
