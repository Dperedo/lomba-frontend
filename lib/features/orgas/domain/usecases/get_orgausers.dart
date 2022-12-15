import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';
import 'package:lomba_frontend/features/orgas/domain/entities/orga.dart';

import '../entities/orgauser.dart';
import '../repositories/orga_repository.dart';

class GetOrgaUsers {
  final OrgaRepository repository;
  GetOrgaUsers(this.repository);
  Future<Either<Failure, List<OrgaUser>>> execute(String orgaId) async {
    return await repository.getOrgaUsers(orgaId);
  }
}
