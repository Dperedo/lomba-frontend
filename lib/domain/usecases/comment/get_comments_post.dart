import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../entities/workflow/comment.dart';
import '../../repositories/comment_repository.dart';

class GetComments {
  final CommentRepository repository;
  GetComments(this.repository);
  Future<Either<Failure, List<Comment>>> execute(String postId, Map<String, int> fieldsOrder, int pageIndex, int pageSize, int voteState,) async {
    return await repository.getCommentsPost(postId, fieldsOrder, pageIndex, pageSize, voteState,);
  }
}
