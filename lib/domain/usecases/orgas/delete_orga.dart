import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../repositories/orga_repository.dart';

///Caso de uso para eliminar una organización
class DeleteOrga {
  final OrgaRepository repository;
  DeleteOrga(this.repository);
  Future<Either<Failure, bool>> execute(String orgaId) async {
    return await repository.deleteOrga(orgaId);
  }
}
