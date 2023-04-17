import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../../core/model_container.dart';
import '../../entities/user.dart';
import '../../repositories/user_repository.dart';

class GetUsersNotInOrga {
  final UserRepository repository;
  GetUsersNotInOrga(this.repository);
  Future<Either<Failure, ModelContainer<User>>> execute(
      String searchText,
      String orgaId,
      Map<String, int> fieldsOrder,
      int pageIndex,
      int pageSize) async {
    return await repository.getUsersNotInOrga(
        searchText, orgaId, fieldsOrder, pageIndex, pageSize);
  }
}
