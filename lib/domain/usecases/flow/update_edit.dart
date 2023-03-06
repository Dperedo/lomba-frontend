import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/domain/entities/flows/post.dart';
import 'package:lomba_frontend/domain/entities/flows/textcontent.dart';

import '../../../core/failures.dart';
import '../../repositories/flow_repository.dart';

class UpdateEdit {
  final FlowRepository repository;
  UpdateEdit(this.repository);
  Future<Either<Failure, Post>> execute(
    String postId, String userId, TextContent text, String title)
    async{
    return await repository.updatePost(postId, userId, text, title);
    }
}