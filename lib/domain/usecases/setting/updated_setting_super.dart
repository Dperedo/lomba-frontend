import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../repositories/setting_repository.dart';

class UpdatedSettingSuper {
  final SettingRepository repository;
  UpdatedSettingSuper(this.repository);
  Future<Either<Failure, bool>> execute(String id,String value) async {
    return await repository.updatedSettingSuper(id, value);
  }
}
