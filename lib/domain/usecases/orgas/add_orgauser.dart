import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../entities/orgauser.dart';
import '../../repositories/orga_repository.dart';

///Caso de uso para agregar una nueva relación orga-user
///
///Se encarga de agregar una relación orga-user y devolver el [OrgaUser] nuevo.
///Debe especificar el Id de organización [orgaId], Id de usuario [userId],
///los roles de la relación en una lista [roles], e indicar si la relación
///está habilitada o no.
class AddOrgaUser {
  final OrgaRepository repository;
  AddOrgaUser(this.repository);
  Future<Either<Failure, OrgaUser>> execute(
      String orgaId, String userId, List<String> roles, bool enabled) async {
    return await repository.addOrgaUser(orgaId, userId, roles, enabled);
  }
}
