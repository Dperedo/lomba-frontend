import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../repositories/local_repository.dart';

class ReadIfRedirectLogin {
  final LocalRepository repository;
  ReadIfRedirectLogin(this.repository);
  Future<Either<Failure, bool>> execute() async {
    return await repository.readIfRedirectLogin();
  }
}
