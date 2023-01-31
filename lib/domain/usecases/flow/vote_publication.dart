import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/model_container.dart';
import '../../entities/flows/post.dart';
import '../../repositories/flow_repository.dart';

class VotePublication {
  final FlowRepository repository;
  VotePublication(this.repository);
  Future<Either<Failure, ModelContainer<Post>>> execute(String orgaId, String userId,String flowId, String stageId,String postId,int voteValue) async {
    return await repository.votePublication(orgaId,userId,flowId,stageId,postId,voteValue);
  }
}
