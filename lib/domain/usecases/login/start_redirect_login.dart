import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../repositories/local_repository.dart';

class StartRedirectLogin {
  final LocalRepository repository;
  StartRedirectLogin(this.repository);
  Future<Either<Failure, bool>> execute() async {
    return await repository.startRedirectLogin();
  }
}
