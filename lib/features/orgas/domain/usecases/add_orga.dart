import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';
import 'package:lomba_frontend/features/orgas/domain/entities/orga.dart';

import '../repositories/orga_repository.dart';

class AddOrga {
  final OrgaRepository repository;
  AddOrga(this.repository);
  Future<Either<Failure, Orga>> execute(Orga orga) async {
    return await repository.addOrga(orga);
  }
}
