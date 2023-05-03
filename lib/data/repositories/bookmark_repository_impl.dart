import 'package:dartz/dartz.dart';

import '../../core/exceptions.dart';
import '../../core/failures.dart';
import '../../domain/entities/workflow/bookmark.dart';
import '../../domain/repositories/bookmark_repository.dart';
import '../datasources/bookmark_data_source.dart';

class BookmarkRepositoryImpl implements BookmarkRepository {
  final BookmarkRemoteDataSource remoteDataSource;

  BookmarkRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Bookmark>> postBookmark(String userId, String postId, String markType, bool giveOrTakeAway) async {
    try {
      final result = await remoteDataSource.postBookmark(userId, postId, markType, giveOrTakeAway);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }
}
