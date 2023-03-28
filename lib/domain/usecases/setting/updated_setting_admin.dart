import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../repositories/setting_repository.dart';

class UpdatedSettingAdmin {
  final SettingRepository repository;
  UpdatedSettingAdmin(this.repository);
  Future<Either<Failure, bool>> execute(String id,String value,String orgaId) async {
    return await repository.updatedSettingAdmin(id, value, orgaId);
  }
}
