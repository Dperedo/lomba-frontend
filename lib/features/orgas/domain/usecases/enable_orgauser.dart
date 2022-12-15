import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../repositories/orga_repository.dart';

class EnableOrgaUser {
  final OrgaRepository repository;
  EnableOrgaUser(this.repository);
  Future<Either<Failure, bool>> execute(
      String orgaId, String userId, bool enableOrDisable) async {
    return await repository.enableOrgaUser(orgaId, userId, enableOrDisable);
  }
}
