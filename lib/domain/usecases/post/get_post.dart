import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/domain/entities/workflow/post.dart';

import '../../../core/failures.dart';
import '../../repositories/post_repository.dart';

class GetPost {
  final PostRepository repository;
  GetPost(this.repository);
  Future<Either<Failure, Post>> execute(
    String postId)
    async{
    return await repository.getPost(postId);
    }
}