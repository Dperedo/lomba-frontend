import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../entities/setting.dart';

abstract class SettingRepository {
  Future<Either<Failure, List<Setting>>> getSettingSuper();
  Future<Either<Failure, List<Setting>>> getSettingAdmin(String orgaId);
  Future<Either<Failure, bool>> updatedSettingSuper(String id,String value);
  Future<Either<Failure, bool>> updatedSettingAdmin(String id,String value,String orgaId);
}
