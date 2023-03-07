
import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/model_container.dart';
import '../../entities/workflow/post.dart';
import '../../repositories/post_repository.dart';

class GetPopularPosts {
  final PostRepository repository;
  GetPopularPosts(this.repository);
  Future<Either<Failure, ModelContainer<Post>>> execute(String orgaId, String userId,String flowId, String stageId,String searchText,int pageIndex,int pageSize) async {
    return await repository.getPopularPosts(orgaId,userId,flowId,stageId,searchText,pageIndex,pageSize);
  }
}