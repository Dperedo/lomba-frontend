import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';
import 'package:lomba_frontend/features/orgas/domain/entities/orga.dart';

import '../repositories/orga_repository.dart';

class DeleteOrgaUser {
  final OrgaRepository repository;
  DeleteOrgaUser(this.repository);
  Future<Either<Failure, bool>> execute(String orgaId, String userId) async {
    return await repository.deleteOrgaUser(orgaId, userId);
  }
}
