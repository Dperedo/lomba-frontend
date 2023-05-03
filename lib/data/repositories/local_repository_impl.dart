import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:lomba_frontend/data/models/session_model.dart';

import '../../core/constants.dart';
import '../../domain/repositories/local_repository.dart';
import '../../core/exceptions.dart';
import '../../core/failures.dart';
import '../../core/validators.dart';
import '../datasources/local_data_source.dart';

///Implementación del repositorio local del dispositivo.
///
///El localStorage aplica a Android, iOS y Web.
///Esta implementación consume el [LocalDataSource]

class LocalRepositoryImpl implements LocalRepository {
  final LocalDataSource localDataSource;

  ///Recibe el [LocalDataSource] en el constructor para así poder invocarlo
  ///desde las pruebas utilizando un Mock del dataSource
  LocalRepositoryImpl({required this.localDataSource});

  ///Método privado para construir una sesión vacía
  SessionModel _getNewSessionModel() {
    return const SessionModel(token: "", username: "", name: "");
  }

  ///Tiene o no LogIn informado en el localStorage del dispositivo.
  @override
  Future<Either<Failure, bool>> hasLogIn() async {
    final result = await getSession();

    bool hasLogIn = false;

    result.fold((l) => {}, (r) => {hasLogIn = (r.token != "")});
    return Right(hasLogIn);
  }

  ///Limpia la sesión del localStorage provocando que se desloguee el usuario
  @override
  Future<Either<Failure, bool>> doLogOff() async {
    await localDataSource.cleanSession();

    return const Right(true);
  }

  ///Consigue la sesión del usuario en el dispositivo (localStorage)
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
      return Future.value(Right(_getNewSessionModel()));
    }
  }

  ///Persiste la sesión en el dispositivo para mantener al usuario logueado
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
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on SocketException {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    } on CacheException {
      return const Left(ConnectionFailure('Failed to write local cache'));
    }
  }

  ///Obtiene los roles especificados en el token de la sesión
  @override
  Future<Either<Failure, List<String>>> getSessionRoles() async {
    List<String> roles = [Roles.roleAnonymous];
    SessionModel session = _getNewSessionModel();

    final result = await getSession();

    result.fold((l) => {}, (r) => {session = r});

    if (session.token != "") {
      final payload = Jwt.parseJwt(session.token);

      if (payload.containsKey("roles") && payload["roles"].toString() != "") {
        roles = payload["roles"].toString().split(",");
      }
    }

    return Right(roles);
  }

  ///Entrega una lista con las opciones de menú para el usuario según roles
  @override
  Future<Either<Failure, List<String>>> getSideMenuListOptions() async {
    List<String> opts = [];
    List<String> roles = [Roles.roleAnonymous];

    final result = await getSessionRoles();

    result.fold((l) => {}, (r) => {roles = r});

    if (roles.contains(Roles.roleAnonymous)) {
      opts.add(SideDrawerUserOptions.optRecent);
      opts.add(SideDrawerUserOptions.optLogIn);
      opts.add(SideDrawerUserOptions.optPopular);
      opts.add(SideDrawerUserOptions.optPost);
    } else {
      opts.add(SideDrawerUserOptions.optPost);
      opts.add(SideDrawerUserOptions.optLogOff);
      opts.add(SideDrawerUserOptions.optProfile);
      opts.add(SideDrawerUserOptions.optDemoList);

      if (roles.contains(Roles.roleSuperAdmin)) {
        opts.add(SideDrawerUserOptions.optOrgas);
        opts.add(SideDrawerUserOptions.optRoles);
        opts.add(SideDrawerUserOptions.optDetailList);
        opts.add(SideDrawerUserOptions.optSettingSuper);
      }

      if (roles.contains(Roles.roleAdmin)) {
        opts.add(SideDrawerUserOptions.optUsers);
        opts.add(SideDrawerUserOptions.optDetailList);
        opts.add(SideDrawerUserOptions.optFlow);
        opts.add(SideDrawerUserOptions.optStage);
        opts.add(SideDrawerUserOptions.optSettingAdmin);
      }

      if (roles.contains(Roles.roleUser)) {
        opts.add(SideDrawerUserOptions.optRecent);
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

  @override
  Future<Either<Failure, bool>> readIfRedirectLogin() async {
    try {
      final start = await localDataSource.getIfRedirectLogin();

      if (start) {
        await localDataSource.cleanRedirectLogin();
      }
      return Right(start);
    } on CacheException {
      return Future.value(const Right(false));
    }
  }

  @override
  Future<Either<Failure, bool>> startRedirectLogin() async {
    try {
      final start = await localDataSource.saveStartRedirectLogin();

      return Right(start);
    } on CacheException {
      return Future.value(const Right(false));
    }
  }
}
