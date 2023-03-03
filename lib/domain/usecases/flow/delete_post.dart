import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/domain/entities/flows/post.dart';
import 'package:lomba_frontend/domain/entities/flows/textcontent.dart';

import '../../../core/failures.dart';
import '../../repositories/flow_repository.dart';

class DeletePost {
  final FlowRepository repository;
  DeletePost(this.repository);
  Future<Either<Failure, Post>> execute(
    String postId, String userId, String stageId)
    async{
    return await repository.deletePost(postId, userId, stageId);
    }
}