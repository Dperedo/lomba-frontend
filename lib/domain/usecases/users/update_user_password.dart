import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../repositories/user_repository.dart';

class UpdateUserPassword {
  final UserRepository repository;
  UpdateUserPassword(this.repository);
  Future<Either<Failure, bool>> execute(String userId, String password) async {
    return await repository.updateUserPassword(userId, password);
  }
}
