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
  Future<Either<Failure, List<Comment>>> getCommentsPost(String postId, Map<String, int> fieldsOrder, int pageIndex, int pageSize, int voteState,) async {
    try {
      final Map<String, dynamic> params = {'voteState': voteState};
      List<dynamic> order = [];
      fieldsOrder.forEach((key, value) {
        order.add([key, value == 1 ? value : -1]);});

      final result = await remoteDataSource.getCommentsPost(postId, order, pageIndex, pageSize, params,);

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
