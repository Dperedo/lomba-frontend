import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../repositories/user_repository.dart';

class DeleteUser {
  final UserRepository repository;
  DeleteUser(this.repository);
  Future<Either<Failure, bool>> execute(String userId) async {
    return await repository.deleteUser(userId);
  }
}
