import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/model_container.dart';
import 'package:lomba_frontend/domain/entities/flows/post.dart';
import '../../../core/failures.dart';
import '../../repositories/flow_repository.dart';

class GetUploadedPosts {
  final FlowRepository repository;
  GetUploadedPosts(this.repository);
  Future<Either<Failure, ModelContainer<Post>>> execute(
    String orgaId,String userId,String flowId,String stageId,bool onlyDrafts,String searchText,Map<String, int> fieldsOrder,int pageIndex,int pageSize
  ) async {
    return await repository.getUploadedPosts(
      orgaId,userId,flowId,stageId,onlyDrafts,searchText,fieldsOrder,pageIndex,pageSize
    );
  }
}
