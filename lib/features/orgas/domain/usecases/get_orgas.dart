import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../entities/orga.dart';
import '../repositories/orga_repository.dart';

class GetOrgas {
  final OrgaRepository repository;
  GetOrgas(this.repository);
  Future<Either<Failure, List<Orga>>> execute(
      String filter, String fieldOrder, double pageNumber, int pageSize) async {
    return await repository.getOrgas(filter, fieldOrder, pageNumber, pageSize);
  }
}
