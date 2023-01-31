import 'package:dartz/dartz.dart';

import '../../../data/models/session_model.dart';
import '../../../core/failures.dart';
import '../../repositories/local_repository.dart';

///Obtiene la sesión del usuario conectado.
class GetSession {
  final LocalRepository repository;
  GetSession(this.repository);
  Future<Either<Failure, SessionModel>> execute() async {
    return await repository.getSession();
  }
}
