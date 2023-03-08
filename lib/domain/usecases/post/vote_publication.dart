import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/model_container.dart';
import '../../entities/workflow/vote.dart';
import '../../repositories/post_repository.dart';

class VotePublication {
  final PostRepository repository;
  VotePublication(this.repository);
  Future<Either<Failure, ModelContainer<Vote>>> execute(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String postId,
      int voteValue) async {
    return await repository.votePublication(
        orgaId, userId, flowId, stageId, postId, voteValue);
  }
}
