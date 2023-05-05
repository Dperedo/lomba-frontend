import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../repositories/comment_repository.dart';

class DeleteComment {
  final CommentRepository repository;
  DeleteComment(this.repository);
  Future<Either<Failure, bool>> execute(String userId, String postId, String commentId)
    async{
    return await repository.deleteComment(userId, postId, commentId);
    }
}