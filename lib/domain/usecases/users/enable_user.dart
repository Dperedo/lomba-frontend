import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../entities/user.dart';
import '../../repositories/user_repository.dart';

class EnableUser {
  final UserRepository repository;
  EnableUser(this.repository);
  Future<Either<Failure, User>> execute(
      String userId, bool enableOrDisable) async {
    return await repository.enableUser(userId, enableOrDisable);
  }
}
