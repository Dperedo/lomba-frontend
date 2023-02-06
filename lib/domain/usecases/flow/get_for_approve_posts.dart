import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/domain/entities/flows/post.dart';
import '../../../core/failures.dart';
import '../../../core/model_container.dart';
import '../../repositories/flow_repository.dart';

class GetForApprovePosts {
  final FlowRepository repository;
  GetForApprovePosts(this.repository);
  Future<Either<Failure, ModelContainer<Post>>> execute(String orgaId, String userId,String flowId, String stageId,String searchText,Map<String, int> fieldsOrder,int pageIndex,int pageSize) async {
    return await repository.getForApprovePosts(orgaId, userId,flowId,stageId,searchText,fieldsOrder,pageIndex,pageSize);
  }
}
