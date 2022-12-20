import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/data/models/session_model.dart';

import '../../failures.dart';

///Interfaz (cáscara) del repositorio Local
///
///De esta manera se definen los métodos que deberá implementar el repositorio
///y que utilizarán los casos de uso. Es sólo la cáscara. Se define como clase
///abstracta porque Dart no maneja interfaces (interface).

abstract class LocalRepository {
  Future<Either<Failure, SessionModel>> getSession();
  Future<Either<Failure, bool>> saveSession(SessionModel session);
  Future<Either<Failure, bool>> hasLogIn();
  Future<Either<Failure, List<String>>> getSideMenuListOptions();
  Future<Either<Failure, bool>> doLogOff();
  Future<Either<Failure, List<String>>> getSessionRoles();
}
