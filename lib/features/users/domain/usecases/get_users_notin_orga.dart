import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/data/models/sort_model.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUsersNotInOrga {
  final UserRepository repository;
  GetUsersNotInOrga(this.repository);
  Future<Either<Failure, List<User>>> execute(
      String orgaId, SortModel sortFields, int pageNumber, int pageSize) async {
    return await repository.getUsersNotInOrga(
        orgaId, sortFields, pageNumber, pageSize);
  }
}
