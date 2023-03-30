import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../repositories/setting_repository.dart';

class UpdatedSettingSuper {
  final SettingRepository repository;
  UpdatedSettingSuper(this.repository);
  Future<Either<Failure, bool>> execute(List<Map<String, dynamic>> settingList) async {
    return await repository.updatedSettingSuper(settingList);
  }
}
