import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:lomba_frontend/features/orgas/data/datasources/orga_remote_data_source.dart';
import 'package:lomba_frontend/features/orgas/data/models/orga_model.dart';

import '../../../../core/exceptions.dart';
import '../../../../core/failures.dart';
import '../../domain/entities/orga.dart';
import '../../domain/entities/orgauser.dart';
import '../../domain/repositories/orga_repository.dart';
import '../models/orgauser_model.dart';

class OrgaRepositoryImpl implements OrgaRepository {
  final OrgaRemoteDataSource remoteDataSource;

  OrgaRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Orga>>> getOrgas(
      String filter, String fieldOrder, double pageNumber, int pageSize) async {
    try {
      final result = await remoteDataSource.getOrgas(
          filter, fieldOrder, pageNumber, pageSize);

      List<Orga> list = [];

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
  Future<Either<Failure, Orga>> getOrga(String orgaId) async {
    try {
      final result = await remoteDataSource.getOrga(orgaId);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<OrgaUser>>> getOrgaUsers(String orgaId) async {
    try {
      final result = await remoteDataSource.getOrgaUsers(orgaId);

      List<OrgaUser> list = [];

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
  Future<Either<Failure, Orga>> addOrga(
      String name, String code, bool enabled) async {
    try {
      OrgaModel orgaModel = OrgaModel(
          id: Guid.newGuid.toString(),
          name: name,
          code: code,
          enabled: enabled,
          builtIn: false);

      final result = await remoteDataSource.addOrga(orgaModel);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, OrgaUser>> addOrgaUser(
      String orgaId, String userId, List<String> roles, bool enabled) async {
    try {
      OrgaUserModel orgaUserModel = OrgaUserModel(
          orgaId: orgaId,
          userId: userId,
          roles: roles,
          enabled: enabled,
          builtIn: false);

      final result = await remoteDataSource.addOrgaUser(orgaUserModel);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteOrga(String orgaId) async {
    try {
      final result = await remoteDataSource.deleteOrga(orgaId);

      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteOrgaUser(
      String orgaId, String userId) async {
    try {
      final result = await remoteDataSource.deleteOrgaUser(orgaId, userId);

      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, Orga>> enableOrga(
      String orgaId, bool enableOrDisable) async {
    try {
      final result = await remoteDataSource.enableOrga(orgaId, enableOrDisable);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, OrgaUser>> enableOrgaUser(
      String orgaId, String userId, bool enableOrDisable) async {
    try {
      final result = await remoteDataSource.enableOrgaUser(
          orgaId, userId, enableOrDisable);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, Orga>> updateOrga(String orgaId, Orga orga) async {
    try {
      OrgaModel orgaModel = OrgaModel(
          id: orgaId,
          name: orga.name,
          code: orga.code,
          enabled: orga.enabled,
          builtIn: orga.builtIn);

      final result = await remoteDataSource.updateOrga(orgaId, orgaModel);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, OrgaUser>> updateOrgaUser(
      String orgaId, String userId, OrgaUser orgaUser) async {
    try {
      OrgaUserModel orgaUserModel = OrgaUserModel(
          orgaId: orgaId,
          userId: userId,
          roles: orgaUser.roles,
          enabled: orgaUser.enabled,
          builtIn: orgaUser.builtIn);

      final result =
          await remoteDataSource.updateOrgaUser(orgaId, userId, orgaUserModel);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
