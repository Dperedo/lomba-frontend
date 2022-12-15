import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../entities/orga.dart';
import '../repositories/orga_repository.dart';

class EnableOrga {
  final OrgaRepository repository;
  EnableOrga(this.repository);
  Future<Either<Failure, Orga>> execute(
      String orgaId, bool enableOrDisable) async {
    return await repository.enableOrga(orgaId, enableOrDisable);
  }
}
