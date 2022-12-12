import 'package:dartz/dartz.dart';

import '../../../../core/failures.dart';

abstract class LoginRepository {
  Future<Either<Failure, bool>> getAuthenticate(
      String username, String password);
}
