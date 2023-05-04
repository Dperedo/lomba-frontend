import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../entities/workflow/comment.dart';
import '../../repositories/comment_repository.dart';

class GetComments {
  final CommentRepository repository;
  GetComments(this.repository);
  Future<Either<Failure, List<Comment>>> execute(String postId, String sort, int pageIndex, int pageSize, Map<String, dynamic> params,) async {
    return await repository.getCommentsPost(postId, sort, pageIndex, pageSize, params,);
  }
}
