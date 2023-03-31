import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../entities/storage/cloudfile.dart';
import '../../repositories/storage_repository.dart';

class GetCloudFile {
  final StorageRepository repository;
  GetCloudFile(this.repository);
  Future<Either<Failure, CloudFile>> execute(String cloudFileId) async {
    return await repository.getCloudFile(cloudFileId);
  }
}
