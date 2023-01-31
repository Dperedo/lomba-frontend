import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/model_container.dart';
import '../../entities/flows/post.dart';
import '../../repositories/flow_repository.dart';

class GetApprovedPosts {
  final FlowRepository repository;
  GetApprovedPosts(this.repository);
  Future<Either<Failure, ModelContainer<Post>>> execute(String orgaId, String userId,String flowId, String stageId,String searchText,Map<String, int> fieldsOrder,int pageIndex,int pageSize) async {
    return await repository.getApprovedPosts(orgaId, userId,flowId,stageId,searchText,fieldsOrder,pageIndex,pageSize);
  }
}
