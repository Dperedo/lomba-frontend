import 'package:dartz/dartz.dart';

import '../../failures.dart';
import '../repositories/local_repository.dart';

class GetHasLogIn {
  final LocalRepository repository;
  GetHasLogIn(this.repository);
  Future<Either<Failure, bool>> execute() async {
    return await repository.hasLogIn();
  }
}
