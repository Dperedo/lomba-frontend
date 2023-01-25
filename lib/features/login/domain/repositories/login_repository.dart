import 'package:dartz/dartz.dart';

import '../../../../core/failures.dart';
import '../../../users/domain/entities/user.dart';

///Interfaz del repositorio del Login de usuario.
///
///Considera sólo [username] y [password]
abstract class LoginRepository {
  Future<Either<Failure, bool>> getAuthenticate(
      String username, String password);
  Future<Either<Failure, bool>> getAuthenticateGoogle(
      User user, String googleToken);
  Future<Either<Failure, bool>> registerUser(String name, String username,
      String email, String orgaId, String password, String role);
}
