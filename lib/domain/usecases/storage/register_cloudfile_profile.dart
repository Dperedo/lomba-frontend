import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../entities/storage/cloudfile.dart';
import '../../repositories/storage_repository.dart';

class RegisterCloudFileProfile {
  final StorageRepository repository;
  RegisterCloudFileProfile(this.repository);
  Future<Either<Failure, List<CloudFile>>> execute(String userId, String orgaId) async {
    return await repository.registerCloudFileUserProfile(userId, orgaId);
  }
}
