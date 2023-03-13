
import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/model_container.dart';
import '../../entities/workflow/post.dart';
import '../../repositories/post_repository.dart';

class GetDetailedListPosts {
  final PostRepository repository;
  GetDetailedListPosts(this.repository);
  Future<Either<Failure, ModelContainer<Post>>> execute(String orgaId, String userId,String flowId, String stageId,String searchText,int pageIndex,int pageSize) async {
    return await repository.getDetailedListPosts(orgaId,userId,flowId,stageId,searchText,pageIndex,pageSize);
  }
}