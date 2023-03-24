import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../entities/storage/filecloud.dart';

abstract class StorageRepository {
  Future<Either<Failure, FileCloud>> uploadFile(
      Uint8List file, String name, String userId, String orgaId);
}
