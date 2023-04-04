import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../entities/storage/cloudfile.dart';
import '../../repositories/storage_repository.dart';

class RegisterCloudFile {
  final StorageRepository repository;
  RegisterCloudFile(this.repository);
  Future<Either<Failure, CloudFile>> execute(String userId, String orgaId) async {
    return await repository.registerCloudFile(userId, orgaId);
  }
}
