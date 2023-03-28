import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../entities/setting.dart';
import '../../repositories/setting_repository.dart';

class GetSettingSuper {
  final SettingRepository repository;
  GetSettingSuper(this.repository);
  Future<Either<Failure, List<Setting>>> execute() async {
    return await repository.getSettingSuper();
  }
}
