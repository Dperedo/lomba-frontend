import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../entities/storage/externaluri.dart';

abstract class ExternalUriRepository {
  Future<Either<Failure, ExternalUri>> postExternalUri(String userId, String uri);
  Future<Either<Failure, ExternalUri>> getExternalUriById(String uriId);
  Future<Either<Failure, ExternalUri>> getExternalUriByUri(String uri);
}
