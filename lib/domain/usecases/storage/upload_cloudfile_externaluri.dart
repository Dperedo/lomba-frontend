import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../entities/storage/cloudfile.dart';
import '../../repositories/storage_repository.dart';

class UploadFileExternalUri {
  final StorageRepository repository;
  UploadFileExternalUri(this.repository);
  Future<Either<Failure, CloudFile>> execute(
      String userId, String uriId, String cloudFileId) async {
    return await repository.uploadFileExternalUri(
      userId, uriId, cloudFileId);
  }
}
