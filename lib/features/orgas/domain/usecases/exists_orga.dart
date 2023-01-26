import 'package:dartz/dartz.dart';
import '../../../../core/failures.dart';
import '../entities/orga.dart';
import '../repositories/orga_repository.dart';


class ExistsOrga {
  final OrgaRepository repository;
  ExistsOrga(this.repository);
  Future<Either<Failure, Orga?>> execute(
      String orgaId, String code) async {
    return await repository.existsOrga(orgaId, code);
  }
}