import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../entities/orgauser.dart';
import '../repositories/orga_repository.dart';

class UpdateOrgaUser {
  final OrgaRepository repository;
  UpdateOrgaUser(this.repository);
  Future<Either<Failure, OrgaUser>> execute(
      String orgaId, String userId, OrgaUser orgaUser) async {
    return await repository.updateOrgaUser(orgaId, userId, orgaUser);
  }
}
