import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../repositories/orga_repository.dart';

///Caso de uso para eliminar una relación orga-user
class DeleteOrgaUser {
  final OrgaRepository repository;
  DeleteOrgaUser(this.repository);
  Future<Either<Failure, bool>> execute(String orgaId, String userId) async {
    return await repository.deleteOrgaUser(orgaId, userId);
  }
}
