import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../entities/user.dart';
import '../repositories/user_repository.dart';

class AddUser {
  final UserRepository repository;
  AddUser(this.repository);
  Future<Either<Failure, User>> execute(
      String name, String username, String email, bool enabled) async {
    return await repository.addUser(name, username, email, enabled);
  }
}
