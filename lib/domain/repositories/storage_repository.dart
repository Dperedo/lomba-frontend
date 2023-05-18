import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../entities/storage/cloudfile.dart';

abstract class StorageRepository {
  Future<Either<Failure, CloudFile>> uploadFile(
      Uint8List file, String cloudFileId);
  Future<Either<Failure, CloudFile>> registerCloudFile(String userId, String orgaId);
  Future<Either<Failure, CloudFile>> getCloudFile(String cloudFileId);
  Future<Either<Failure, CloudFile>> uploadFileUserProfile(
      String userId, Uint8List file, String cloudFileId);
  Future<Either<Failure, List<CloudFile>>> registerCloudFileUserProfile(String userId, String orgaId);
  Future<Either<Failure, CloudFile>> uploadFileExternalUri(
      String userId, String uriId, String cloudFileId);
}
