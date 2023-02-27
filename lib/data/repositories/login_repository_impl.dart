import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:lomba_frontend/data/models/session_model.dart';

import '../../core/exceptions.dart';
import '../../core/failures.dart';
import '../../domain/entities/session.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/local_data_source.dart';
import '../datasources/login_data_source.dart';
import '../datasources/user_data_source.dart';
import '../models/user_model.dart';

///Implementación de métodos del repositorio [LoginRepository]
///
///Esta implementación controla las excepciones que pueden generarse en
///el DataSource (origen de los datos) cuando existen problemas de (por ejemplo)
///comunicación con el origen.
///Es en esta implementación que los errores se capturan y se convierten en
///retornos Left() con mensaje de falla (Failure)
class LoginRepositoryImpl implements LoginRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final UserRemoteDataSource userDataSource;

  ///El constructor de esta implementación recibe datasource remoto y local.
  ///
  ///Recibe dos dataSources porque debe conectar con el backend y depositar
  ///además la sesión en el localStorage.
  LoginRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.userDataSource});

  @override
  Future<Either<Failure, Session>> getAuthenticate(
      String username, String password) async {
    try {
      final result = await remoteDataSource.getAuthenticate(username, password);

      ///Construye un session a partir de los datos del LocalAccessModel
      SessionModel session = SessionModel(
          token: result.token, username: result.username, name: result.name);

      //-------------------------------------------------------------------------Solo cuando sea un Orga
      ///Persiste el objeto [SessionModel] en el localStorage con los datos
      ///del usuario conectado.
      localDataSource.saveSession(session);
      //--------------------------------------------------------------------------

      return Right(session);
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on CacheException {
      return const Left(ConnectionFailure('Failed to write local cache'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, bool>> registerUser(String name, String username,
      String email, String orgaId, String password, String role) async {
    try {
      UserModel userModel = UserModel(
          id: '',
          name: name,
          username: username,
          email: email,
          enabled: true,
          builtIn: false);
      final result = await remoteDataSource.registerUser(
          userModel, orgaId, password, role);

      return Right(result);
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on CacheException {
      return const Left(ConnectionFailure('Failed to write local cache'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, Session>> changeOrga(
      String username, String orgaId) async {
    try {
      final result = await remoteDataSource.changeOrga(username, orgaId);

      ///Construye un session a partir de los datos del LocalAccessModel
      //SessionModel session = SessionModel(token: result.token, username: result.username, name: result.name);

      //-------------------------------------------------------------------------Solo cuando sea un Orga
      ///Persiste el objeto [SessionModel] en el localStorage con los datos
      ///del usuario conectado.
      localDataSource.saveSession(result);
      //--------------------------------------------------------------------------

      //if (result != '') {
      return Right(result);
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on CacheException {
      return const Left(ConnectionFailure('Failed to write local cache'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, Session>> getAuthenticateGoogle(
      User user, String googleToken) async {
    try {
      UserModel userModel = UserModel(
          id: user.id,
          name: user.name,
          username: user.username,
          email: user.email,
          enabled: user.enabled,
          builtIn: user.builtIn);

      final result =
          await remoteDataSource.getAuthenticateGoogle(userModel, googleToken);

      ///Construye un session a partir de los datos del LocalAccessModel
      SessionModel session = SessionModel(
          token: result.token, username: result.username, name: result.name);

      ///Persiste el objeto [SessionModel] en el localStorage con los datos
      ///del usuario conectado.
      localDataSource.saveSession(session);

      return Right(session);
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on CacheException {
      return const Left(ConnectionFailure('Failed to write local cache'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }
}
