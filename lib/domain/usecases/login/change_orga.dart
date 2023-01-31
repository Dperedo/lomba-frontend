import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../entities/session.dart';
import '../../repositories/login_repository.dart';

class ChangeOrga {
  final LoginRepository repository;
  ChangeOrga(this.repository);
  Future<Either<Failure, Session>> execute(
      String username, String orgaId) async {
    return await repository.changeOrga(username, orgaId);
  }
}
