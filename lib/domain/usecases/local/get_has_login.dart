import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../repositories/local_repository.dart';

///Consigue respuesta si el usuario está logueado.
///
///Caso de uso para conocer el estado de la sesión del usuario actual.
class GetHasLogIn {
  final LocalRepository repository;
  GetHasLogIn(this.repository);
  Future<Either<Failure, bool>> execute() async {
    return await repository.hasLogIn();
  }
}
