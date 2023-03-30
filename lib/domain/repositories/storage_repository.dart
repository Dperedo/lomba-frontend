import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../entities/storage/cloudfile.dart';

abstract class StorageRepository {
  Future<Either<Failure, CloudFile>> uploadFile(
      Uint8List file, String name, String userId, String orgaId);
}
