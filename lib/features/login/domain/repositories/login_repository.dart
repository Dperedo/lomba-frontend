import 'package:dartz/dartz.dart';

import '../../../../core/failures.dart';
import '../entities/token.dart';

abstract class LoginRepository {
  Future<Either<Failure, Token>> getAuthenticate(
      String username, String password);
}
