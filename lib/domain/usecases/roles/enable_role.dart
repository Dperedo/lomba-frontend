import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../entities/role.dart';
import '../../repositories/role_repository.dart';

class EnableRole {
  final RoleRepository repository;
  EnableRole(this.repository);
  Future<Either<Failure, Role>> execute(
      String name, bool enableOrDisable) async {
    return await repository.enableRole(name, enableOrDisable);
  }
}
