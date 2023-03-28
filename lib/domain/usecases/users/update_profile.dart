import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';
import 'package:lomba_frontend/domain/entities/user.dart';

import '../../repositories/user_repository.dart';

class UpdateProfile {
  final UserRepository repository;
  UpdateProfile(this.repository);
  Future<Either<Failure, User>> execute(String userId, User user) async {
    return await repository.updateProfile(userId, user);
  }
}
