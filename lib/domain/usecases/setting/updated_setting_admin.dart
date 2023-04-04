import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../repositories/setting_repository.dart';

class UpdatedSettingAdmin {
  final SettingRepository repository;
  UpdatedSettingAdmin(this.repository);
  Future<Either<Failure, bool>> execute(List<Map<String, dynamic>> settingList,String orgaId) async {
    return await repository.updatedSettingAdmin(settingList, orgaId);
  }
}
