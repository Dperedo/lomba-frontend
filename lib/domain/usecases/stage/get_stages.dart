import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../entities/workflow/stage.dart';
import '../../repositories/stage_repository.dart';

class GetStages {
  final StageRepository repository;
  GetStages(this.repository);
  Future<Either<Failure, List<Stage>>> execute() async {
    return await repository.getStages();
  }
}
