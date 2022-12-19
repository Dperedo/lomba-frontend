import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:lomba_frontend/core/data/models/session_model.dart';

import '../../constants.dart';
import '../../domain/repositories/local_repository.dart';
import '../../exceptions.dart';
import '../../failures.dart';
import '../../validators.dart';
import '../datasources/local_data_source.dart';

class LocalRepositoryImpl implements LocalRepository {
  final LocalDataSource localDataSource;

  LocalRepositoryImpl({required this.localDataSource});

  SessionModel _getNewSessionModel() {
    return const SessionModel(token: "", username: "", name: "");
  }

  @override
  Future<Either<Failure, bool>> hasLogIn() async {
    final result = await getSession();

    bool hasLogIn = false;

    result.fold((l) => {}, (r) => {hasLogIn = (r.token != "")});
    return Right(hasLogIn);
  }

  @override
  Future<Either<Failure, bool>> doLogOff() async {
    await localDataSource.cleanSession();

    return const Right(true);
  }

  @override
  Future<Either<Failure, SessionModel>> getSession() async {
    try {
      if (!await localDataSource.hasSession()) {
        return Future.value(Right(_getNewSessionModel()));
      }

      final sessionModel = await localDataSource.getSavedSession();

      if (!Validators.validateToken(sessionModel.token)) {
        return Future.value(Right(_getNewSessionModel()));
      }

      return Right(sessionModel);
    } on CacheException {
      return const Left(ConnectionFailure('Failed to read local cache'));
    }
  }

  @override
  Future<Either<Failure, bool>> saveSession(SessionModel session) async {
    try {
      final result = await localDataSource.saveSession(session);

      if (result) {
        return const Right(true);
      } else {
        return const Right(false);
      }
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on CacheException {
      return const Left(ConnectionFailure('Failed to write local cache'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getSessionRoles() async {
    List<String> roles = [Roles.roleAnonymous];
    SessionModel session = _getNewSessionModel();

    final result = await getSession();

    result.fold((l) => {}, (r) => {session = r});

    if (session.token != "") {
      final payload = Jwt.parseJwt(session.token);

      if (payload.containsKey("roleId") && payload["roleId"].toString() != "") {
        roles = payload["roleId"].toString().split(",");
      }
    }

    return Right(roles);
  }

  @override
  Future<Either<Failure, List<String>>> getSideMenuListOptions() async {
    List<String> opts = [SideDrawerUserOptions.optHome];
    List<String> roles = [Roles.roleAnonymous];

    final result = await getSessionRoles();

    result.fold((l) => {}, (r) => {roles = r});

    if (roles.contains(Roles.roleAnonymous)) {
      opts.add(SideDrawerUserOptions.optLogIn);
    } else {
      opts.add(SideDrawerUserOptions.optLogOff);
      opts.add(SideDrawerUserOptions.optProfile);

      if (roles.contains(Roles.roleSuperAdmin)) {
        opts.add(SideDrawerUserOptions.optOrgas);
        opts.add(SideDrawerUserOptions.optUsers);
        opts.add(SideDrawerUserOptions.optRoles);
      }

      if (roles.contains(Roles.roleAdmin)) {
        opts.add(SideDrawerUserOptions.optUsers);
      }

      if (roles.contains(Roles.roleUser)) {
        opts.add(SideDrawerUserOptions.optAddContent);
        opts.add(SideDrawerUserOptions.optViewed);
        opts.add(SideDrawerUserOptions.optPopular);
        opts.add(SideDrawerUserOptions.optUploaded);
      }
      if (roles.contains(Roles.roleReviewer)) {
        opts.add(SideDrawerUserOptions.optToBeApproved);
        opts.add(SideDrawerUserOptions.optApproved);
        opts.add(SideDrawerUserOptions.optRejected);
      }
    }
    return Right(opts);
  }
}
