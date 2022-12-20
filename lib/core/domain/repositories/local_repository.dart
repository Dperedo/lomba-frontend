import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/data/models/session_model.dart';

import '../../failures.dart';

abstract class LocalRepository {
  Future<Either<Failure, SessionModel>> getSession();
  Future<Either<Failure, bool>> saveSession(SessionModel session);
  Future<Either<Failure, bool>> hasLogIn();
  Future<Either<Failure, List<String>>> getSideMenuListOptions();
  Future<Either<Failure, bool>> doLogOff();
  Future<Either<Failure, List<String>>> getSessionRoles();
}
