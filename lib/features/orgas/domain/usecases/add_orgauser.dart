import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';
import 'package:lomba_frontend/features/orgas/domain/entities/orga.dart';

import '../entities/orgauser.dart';
import '../repositories/orga_repository.dart';

class AddOrgaUser {
  final OrgaRepository repository;
  AddOrgaUser(this.repository);
  Future<Either<Failure, OrgaUser>> execute(OrgaUser orgaUser) async {
    return await repository.addOrgaUser(orgaUser);
  }
}
