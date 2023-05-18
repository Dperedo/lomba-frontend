import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../entities/storage/externaluri.dart';
import '../../repositories/externaluri_repository.dart';

class GetExternalUriById {
  final ExternalUriRepository repository;
  GetExternalUriById(this.repository);
  Future<Either<Failure, ExternalUri>> execute(String uriId) async {
    return await repository.getExternalUriById(uriId);
  }
}
