import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../repositories/orga_repository.dart';

class EnableOrga {
  final OrgaRepository repository;
  EnableOrga(this.repository);
  Future<Either<Failure, bool>> execute(
      String orgaId, bool enableOrDisable) async {
    return await repository.enableOrga(orgaId, enableOrDisable);
  }
}
