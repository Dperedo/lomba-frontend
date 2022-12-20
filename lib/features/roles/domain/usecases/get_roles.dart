import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../entities/role.dart';
import '../repositories/role_repository.dart';

class GetRoles {
  final RoleRepository repository;
  GetRoles(this.repository);
  Future<Either<Failure, List<Role>>> execute() async {
    return await repository.getRoles();
  }
}
