import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/domain/usecases/login/change_orga.dart';
import 'package:lomba_frontend/data/models/orga_model.dart';

import '../entities/session.dart';
import '../../core/failures.dart';
import '../entities/orga.dart';
import '../../data/models/login_access_model.dart';
import '../entities/user.dart';

///Interfaz del repositorio del Login de usuario.
///
///Considera sólo [username] y [password]
abstract class LoginRepository {
  Future<Either<Failure, Session>> getAuthenticate(
      String username, String password);
  Future<Either<Failure, bool>> registerUser(String name, String username,
      String email, String orgaId, String password, String role);
  Future<Either<Failure, Session>> changeOrga(String username, String orgaId);
  Future<Either<Failure, bool>> getAuthenticateGoogle(
      User user, String googleToken);
}
