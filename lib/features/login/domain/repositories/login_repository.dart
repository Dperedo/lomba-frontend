import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/features/users/data/models/user_model.dart';

import '../../../../core/failures.dart';

///Interfaz del repositorio del Login de usuario.
///
///Considera sólo [username] y [password]
abstract class LoginRepository {
  Future<Either<Failure, bool>> getAuthenticate(String username, String password);
  Future<Either<Failure, bool>> registerUser(String name, String username, String email, String orgaId, String password, String role);
}
