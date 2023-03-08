import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../entities/workflow/flow.dart';
import '../../repositories/flow_repository.dart';

class GetFlow {
  final FlowRepository repository;
  GetFlow(this.repository);
  Future<Either<Failure, Flow>> execute(String flowId) async {
    return await repository.getFlow(flowId);
  }
}
