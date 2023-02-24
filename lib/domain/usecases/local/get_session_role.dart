import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../repositories/local_repository.dart';

///Obtiene la sesión del usuario conectado.
class GetSessionRole {
  final LocalRepository repository;
  GetSessionRole(this.repository);
  Future<Either<Failure, List<String>>> execute() async {
    return await repository.getSessionRoles();
  }
}