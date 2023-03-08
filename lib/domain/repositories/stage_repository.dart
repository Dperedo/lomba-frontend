import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../entities/workflow/stage.dart';

abstract class StageRepository {
  Future<Either<Failure, List<Stage>>> getStages();
  Future<Either<Failure, Stage>> getStage(String stageId);
}
