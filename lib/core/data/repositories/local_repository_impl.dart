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
  Future<Either<Failure, String>> getSessionRole() async {
    String role = Roles.Anonymous;
    SessionModel session = _getNewSessionModel();

    final result = await getSession();

    result.fold((l) => {}, (r) => {session = r});

    if (session.token != "") {
      final payload = Jwt.parseJwt(session.token);
      if (payload.containsKey("roleId") &&
          Roles.toList().contains(payload["roleId"])) {
        role = payload["roleId"];
      }
    }

    return Right(role);
  }

  @override
  Future<Either<Failure, List<String>>> getSideMenuListOptions() async {
    List<String> opts = [SideDrawerUserOptions.Home];
    String role = Roles.Anonymous;

    final result = await getSessionRole();

    result.fold((l) => {}, (r) => {role = r});

    if (role == Roles.Anonymous) {
      opts.add(SideDrawerUserOptions.LogIn);
    } else {
      opts.add(SideDrawerUserOptions.LogOff);
      opts.add(SideDrawerUserOptions.Profile);

      if (role == Roles.SuperAdmin) {
        opts.add(SideDrawerUserOptions.Orgas);
        opts.add(SideDrawerUserOptions.Users);
        opts.add(SideDrawerUserOptions.Roles);
      } else if (role == Roles.Admin) {
        opts.add(SideDrawerUserOptions.Users);
      }
    }
    return Right(opts);
  }
}
