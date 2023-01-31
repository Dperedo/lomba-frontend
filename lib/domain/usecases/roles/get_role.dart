import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../entities/role.dart';
import '../../repositories/role_repository.dart';

class GetRole {
  final RoleRepository repository;
  GetRole(this.repository);
  Future<Either<Failure, Role>> execute(String name) async {
    return await repository.getRole(name);
  }
}
