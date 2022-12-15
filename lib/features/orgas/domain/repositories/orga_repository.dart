import 'package:dartz/dartz.dart';

import '../../../../core/failures.dart';
import '../entities/orga.dart';
import '../entities/orgauser.dart';

abstract class OrgaRepository {
  Future<Either<Failure, List<Orga>>> getOrgas(
      String filter, String fieldOrder, double pageNumber, int pageSize);
  Future<Either<Failure, Orga>> getOrga(String orgaId);
  Future<Either<Failure, List<OrgaUser>>> getOrgaUsers(String orgaId);
  Future<Either<Failure, Orga>> addOrga(String name, String code, bool enabled);
  Future<Either<Failure, OrgaUser>> addOrgaUser(
      String orgaId, String userId, List<String> roles, bool enabled);
  Future<Either<Failure, bool>> deleteOrga(String orgaId);
  Future<Either<Failure, bool>> deleteOrgaUser(String orgaId, String userId);
  Future<Either<Failure, bool>> enableOrga(String orgaId, bool enableOrDisable);
  Future<Either<Failure, bool>> enableOrgaUser(
      String orgaId, String userId, bool enableOrDisable);
  Future<Either<Failure, Orga>> updateOrga(String orgaId, Orga orga);
  Future<Either<Failure, OrgaUser>> updateOrgaUser(
      String orgaId, String userId, OrgaUser orgaUser);
}
