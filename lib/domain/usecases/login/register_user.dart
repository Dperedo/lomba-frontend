import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../repositories/login_repository.dart';

class RegisterUser {
  final LoginRepository repository;
  RegisterUser(this.repository);
  Future<Either<Failure, bool>> execute(String name, String username,
      String email, String orgaId, String password, String role) async {
    return await repository.registerUser(
        name, username, email, orgaId, password, role);
  }
}
