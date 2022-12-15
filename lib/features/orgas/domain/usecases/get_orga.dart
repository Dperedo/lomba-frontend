import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../entities/orga.dart';
import '../repositories/orga_repository.dart';

class GetOrga {
  final OrgaRepository repository;
  GetOrga(this.repository);
  Future<Either<Failure, Orga>> execute(String orgaId) async {
    return await repository.getOrga(orgaId);
  }
}
