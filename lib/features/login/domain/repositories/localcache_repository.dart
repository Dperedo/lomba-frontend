import 'package:dartz/dartz.dart';

import '../../../../core/failures.dart';

abstract class LocalCacheRepository {
  Future<Either<Failure, bool>> validateLogin();
}
