import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../entities/user.dart';
import '../../repositories/user_repository.dart';

class ExistsUser {
  final UserRepository repository;
  ExistsUser(this.repository);
  Future<Either<Failure, User?>> execute(
      String userId, String username, String email) async {
    return await repository.existsUser(userId, username, email);
  }
}
