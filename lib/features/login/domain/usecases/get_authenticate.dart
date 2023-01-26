import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../../../core/domain/entities/session.dart';
import '../repositories/login_repository.dart';

///Caso de uso para la autenticación de usuario.
///
///Se encarga de dejar al usuario autenticado en el dispositivo a partir
///de la información recibida y la persistencia del token de usuario
///almacenado en una [SessionModel] en la localStorage.
class GetAuthenticate {
  final LoginRepository repository;
  GetAuthenticate(this.repository);
  Future<Either<Failure, Session>> execute(
      String username, String password) async {
    return await repository.getAuthenticate(username, password);
  }
}
