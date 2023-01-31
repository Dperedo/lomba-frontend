import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';
import 'package:lomba_frontend/domain/entities/user.dart';

import '../../repositories/user_repository.dart';

class UpdateUser {
  final UserRepository repository;
  UpdateUser(this.repository);
  Future<Either<Failure, User>> execute(String userId, User user) async {
    return await repository.updateUser(userId, user);
  }
}
