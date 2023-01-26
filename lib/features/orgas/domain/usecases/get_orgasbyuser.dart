import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../entities/orga.dart';
import '../repositories/orga_repository.dart';

///Caso de uso para obtener una lista de organizaciones
class GetOrgasByUser {
  final OrgaRepository repository;
  GetOrgasByUser(this.repository);

  Future<Either<Failure, List<Orga>>> execute(
      String userId) async {
    return await repository.getOrgasByUser(userId);
  }
}
