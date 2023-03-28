import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../entities/user.dart';
import '../../repositories/user_repository.dart';

class ExistsProfile {
  final UserRepository repository;
  ExistsProfile(this.repository);
  Future<Either<Failure, User?>> execute(
      String userId, String username, String email) async {
    return await repository.existsProfile(userId, username, email);
  }
}
