import 'package:dartz/dartz.dart';

import '../../../../core/failures.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getUsers(String orgaId, String filter,
      String fieldOrder, double pageNumber, int pageSize);
  Future<Either<Failure, User>> getUser(String userId);
  Future<Either<Failure, User>> addUser(
      String name, String username, String email, bool enabled);
  Future<Either<Failure, bool>> deleteUser(String userId);
  Future<Either<Failure, User>> enableUser(String userId, bool enableOrDisable);
  Future<Either<Failure, User>> updateUser(String userId, User user);
}
