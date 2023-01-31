import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../entities/orgauser.dart';
import '../../repositories/orga_repository.dart';

///Caso de uso para habilitar o deshabilitar una relación orga-user
class EnableOrgaUser {
  final OrgaRepository repository;
  EnableOrgaUser(this.repository);
  Future<Either<Failure, OrgaUser>> execute(
      String orgaId, String userId, bool enableOrDisable) async {
    return await repository.enableOrgaUser(orgaId, userId, enableOrDisable);
  }
}
