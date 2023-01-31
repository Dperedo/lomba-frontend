import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../entities/role.dart';

abstract class RoleRepository {
  Future<Either<Failure, List<Role>>> getRoles();
  Future<Either<Failure, Role>> getRole(String name);
  Future<Either<Failure, Role>> enableRole(String name, bool enableOrDisable);
}
