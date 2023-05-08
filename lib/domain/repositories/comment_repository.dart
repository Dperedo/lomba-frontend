import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../entities/workflow/comment.dart';

abstract class CommentRepository {
  Future<Either<Failure, Comment>> postComment(String userId, String postId, String text);
  Future<Either<Failure, bool>> deleteComment(String userId, String postId, String commentId);
  Future<Either<Failure, List<Comment>>> getCommentsPost(String postId, Map<String, int> fieldsOrder, int pageIndex, int pageSize, int voteState,);
}
