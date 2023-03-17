import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/domain/entities/workflow/post.dart';

import '../../../core/failures.dart';
import '../../repositories/post_repository.dart';

class EnablePost {
  final PostRepository repository;
  EnablePost(this.repository);
  Future<Either<Failure, Post>> execute(
    String postId, bool enableOrDisable)
    async{
    return await repository.enablePost(postId, enableOrDisable);
    }
}