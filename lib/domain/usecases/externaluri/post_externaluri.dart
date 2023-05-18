import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../entities/storage/externaluri.dart';
import '../../repositories/externaluri_repository.dart';

class PostExternalUri {
  final ExternalUriRepository repository;
  PostExternalUri(this.repository);
  Future<Either<Failure, ExternalUri>> execute(String userId, String uri) async {
    return await repository.postExternalUri(userId, uri);
  }
}
