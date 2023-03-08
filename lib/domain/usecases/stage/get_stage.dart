import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../entities/workflow/stage.dart';
import '../../repositories/stage_repository.dart';

class GetStage {
  final StageRepository repository;
  GetStage(this.repository);
  Future<Either<Failure, Stage>> execute(String stageId) async {
    return await repository.getStage(stageId);
  }
}
