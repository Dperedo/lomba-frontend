import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../entities/workflow/comment.dart';
import '../../repositories/comment_repository.dart';

class PostComment {
  final CommentRepository repository;
  PostComment(this.repository);
  Future<Either<Failure, Comment>> execute(String userId, String postId, String text)
    async{
    return await repository.postComment(userId, postId, text);
    }
}