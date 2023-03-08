import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../entities/workflow/flow.dart';

abstract class FlowRepository {
  Future<Either<Failure, List<Flow>>> getFlows();
  Future<Either<Failure, Flow>> getFlow(String flowId);
}
