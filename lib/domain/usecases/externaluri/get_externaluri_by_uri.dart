import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../entities/storage/externaluri.dart';
import '../../repositories/externaluri_repository.dart';

class GetExternalUriByUri {
  final ExternalUriRepository repository;
  GetExternalUriByUri(this.repository);
  Future<Either<Failure, ExternalUri>> execute(String uri) async {
    return await repository.getExternalUriByUri(uri);
  }
}
