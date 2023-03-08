import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../entities/workflow/flow.dart';
import '../../repositories/flow_repository.dart';

class GetFlows {
  final FlowRepository repository;
  GetFlows(this.repository);
  Future<Either<Failure, List<Flow>>> execute() async {
    return await repository.getFlows();
  }
}
