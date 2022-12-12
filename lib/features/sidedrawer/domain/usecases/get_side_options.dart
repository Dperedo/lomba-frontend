import 'package:dartz/dartz.dart';

import '../../../../core/domain/repositories/local_repository.dart';
import '../../../../core/failures.dart';

class GetSideOptions {
  final LocalRepository repository;
  GetSideOptions(this.repository);
  Future<Either<Failure, List<String>>> execute() async {
    return await repository.getSideMenuListOptions();
  }
}
