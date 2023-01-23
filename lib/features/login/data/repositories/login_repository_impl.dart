import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:lomba_frontend/core/data/models/session_model.dart';

import '../../../../core/data/datasources/local_data_source.dart';
import '../../../../core/exceptions.dart';
import '../../../../core/failures.dart';
import '../../../users/data/datasources/user_remote_data_source.dart';
import '../../../users/data/models/user_model.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/remote_data_source.dart';

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
      {required this.remoteDataSource, required this.localDataSource, required this.userDataSource});

  @override
  Future<Either<Failure, bool>> getAuthenticate(String username, String password) async {
    try {
      final result = await remoteDataSource.getAuthenticate(username, password);

      ///Construye un session a partir de los datos del LocalAccessModel
      SessionModel session = SessionModel(
          token: result.token, username: result.username, name: result.name);

      ///Persiste el objeto [SessionModel] en el localStorage con los datos
      ///del usuario conectado.
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

  
  @override
  Future<Either<Failure, bool>> registerUser(String name, String username, String email, String orgaId, String password, String role) async {
    try {
      UserModel userModel = UserModel(
          id: Guid.newGuid.toString(),
          name: name,
          username: username,
          email: email,
          enabled: true,
          builtIn: false);
      final result = await remoteDataSource.registerUser(userModel, orgaId, password, role);

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
