import 'package:dartz/dartz.dart';

import '../../../../core/domain/repositories/local_repository.dart';
import '../../../../core/failures.dart';

class DoLogOff {
  final LocalRepository repository;
  DoLogOff(this.repository);
  Future<Either<Failure, bool>> execute() async {
    return await repository.doLogOff();
  }
}
