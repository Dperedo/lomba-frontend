import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../entities/orgauser.dart';
import '../repositories/orga_repository.dart';

class AddOrgaUser {
  final OrgaRepository repository;
  AddOrgaUser(this.repository);
  Future<Either<Failure, OrgaUser>> execute(
      String orgaId, String userId, List<String> roles, bool enabled) async {
    return await repository.addOrgaUser(orgaId, userId, roles, enabled);
  }
}
