import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../entities/session.dart';
import '../../entities/user.dart';
import '../../repositories/login_repository.dart';

///Caso de uso para la autenticación de usuario.
///
///Se encarga de dejar al usuario autenticado en el dispositivo a partir
///de la información recibida y la persistencia del token de usuario
///almacenado en una [SessionModel] en la localStorage.
class GetAuthenticateGoogle {
  final LoginRepository repository;
  GetAuthenticateGoogle(this.repository);
  Future<Either<Failure, Session>> execute(
      User user, String googleToken) async {
    return await repository.getAuthenticateGoogle(user, googleToken);
  }
}
