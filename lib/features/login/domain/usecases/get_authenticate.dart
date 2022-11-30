import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../entities/token.dart';
import '../repositories/login_repository.dart';

class GetAuthenticate {
  final LoginRepository repository;
  GetAuthenticate(this.repository);
  Future<Either<Failure, Token>> execute(
      String username, String password) async {
    return await repository.getAuthenticate(username, password);
  }
}
