import 'package:dartz/dartz.dart';

import '../../../../core/failures.dart';

///Interfaz del repositorio del Login de usuario.
///
///Considera sólo [username] y [password]
abstract class LoginRepository {
  Future<Either<Failure, bool>> getAuthenticate(
      String username, String password);
}
