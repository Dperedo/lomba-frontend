import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../entities/user.dart';
import '../../repositories/user_repository.dart';

class GetUsers {
  final UserRepository repository;
  GetUsers(this.repository);
  Future<Either<Failure, List<User>>> execute(String orgaId, String filter,
      String fieldOrder, double pageNumber, int pageSize) async {
    return await repository.getUsers(
        orgaId, filter, fieldOrder, pageNumber, pageSize);
  }
}
