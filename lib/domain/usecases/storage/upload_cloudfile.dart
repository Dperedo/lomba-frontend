import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../entities/storage/cloudfile.dart';
import '../../repositories/storage_repository.dart';

class UploadFile {
  final StorageRepository repository;
  UploadFile(this.repository);
  Future<Either<Failure, CloudFile>> execute(
      Uint8List file, String name, String userId, String orgaId) async {
    return await repository.uploadFile(file, name, userId, orgaId);
  }
}
