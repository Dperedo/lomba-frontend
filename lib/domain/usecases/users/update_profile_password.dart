import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../repositories/user_repository.dart';

class UpdateProfilePassword {
  final UserRepository repository;
  UpdateProfilePassword(this.repository);
  Future<Either<Failure, bool>> execute(String userId, String password) async {
    return await repository.updateProfilePassword(userId, password);
  }
}
