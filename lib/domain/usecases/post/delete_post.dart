import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/domain/entities/workflow/post.dart';

import '../../../core/failures.dart';
import '../../repositories/post_repository.dart';

class DeletePost {
  final PostRepository repository;
  DeletePost(this.repository);
  Future<Either<Failure, Post>> execute(
    String postId, String userId)
    async{
    return await repository.deletePost(postId, userId);
    }
}