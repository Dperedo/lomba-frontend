import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/domain/entities/workflow/post.dart';

import '../../../core/failures.dart';
import '../../repositories/post_repository.dart';

class GetWithUserPost {
  final PostRepository repository;
  GetWithUserPost(this.repository);
  Future<Either<Failure, Post>> execute(
      String postId, String userId, String flowId, String stageId) async {
    return await repository.getPostWithUser(postId, userId, flowId, stageId);
  }
}
