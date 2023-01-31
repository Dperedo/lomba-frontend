import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../entities/user.dart';
import '../../repositories/user_repository.dart';

class GetUser {
  final UserRepository repository;
  GetUser(this.repository);
  Future<Either<Failure, User>> execute(String userId) async {
    return await repository.getUser(userId);
  }
}
