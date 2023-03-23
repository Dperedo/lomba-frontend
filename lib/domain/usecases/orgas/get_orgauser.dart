import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../entities/orgauser.dart';
import '../../repositories/orga_repository.dart';

///Caso de uso para obtener una lista de organizaciones
class GetOrgaUser {
  final OrgaRepository repository;
  GetOrgaUser(this.repository);

  Future<Either<Failure, List<OrgaUser>>> execute(String orgaId, String userId) async {
    return await repository.getOrgaUser(orgaId,userId);
  }
}
