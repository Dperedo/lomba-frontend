import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../entities/storage/cloudfile.dart';
import '../../repositories/storage_repository.dart';

class UploadFileProfile {
  final StorageRepository repository;
  UploadFileProfile(this.repository);
  Future<Either<Failure, List<CloudFile>>> execute(
      String userId, Uint8List file, String cloudFileId) async {
    return await repository.uploadFileUserProfile(userId, file, cloudFileId);
  }
}
