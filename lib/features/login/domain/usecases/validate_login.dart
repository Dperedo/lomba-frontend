import 'package:dartz/dartz.dart';

import '../../../../core/failures.dart';
import '../entities/token.dart';
import '../repositories/localcache_repository.dart';

class ValidateLogin {
  final LocalCacheRepository repository;
  ValidateLogin(this.repository);
  Future<Either<Failure, bool>> execute() async {
    return await repository.validateLogin();
  }
}
