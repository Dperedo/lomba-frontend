import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/domain/entities/workflow/post.dart';

import '../../../core/failures.dart';
import '../../repositories/post_repository.dart';

class ChangeStagePost {
  final PostRepository repository;
  ChangeStagePost(this.repository);
  Future<Either<Failure, Post>> execute(
    String postId, String flowId, String stageId)
    async{
    return await repository.changeStagePost(postId, flowId, stageId);
    }
}