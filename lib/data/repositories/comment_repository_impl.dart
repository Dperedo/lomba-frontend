import 'package:dartz/dartz.dart';

import '../../core/exceptions.dart';
import '../../core/failures.dart';
import '../../domain/entities/workflow/comment.dart';
import '../../domain/repositories/comment_repository.dart';
import '../datasources/comment_data_source.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentRemoteDataSource remoteDataSource;

  CommentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Comment>> postComment(String userId, String postId, String text) async {
    try {
      final result = await remoteDataSource.postComment(userId, postId, text);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteComment(String userId, String postId, String commentId) async {
    try {
      final result = await remoteDataSource.deleteComment(userId, postId, commentId);

      return Right(result);
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, List<Comment>>> getCommentsPost(String postId, String sort, int pageIndex, int pageSize, Map<String, dynamic> params,) async {
    try {
      final result = await remoteDataSource.getCommentsPost(postId, sort, pageIndex, pageSize, params,);

      List<Comment> list = [];

      if (result.isNotEmpty) {
        for (var element in result) {
          list.add(element.toEntity());
        }
      }

      return Right(list);
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }
}
