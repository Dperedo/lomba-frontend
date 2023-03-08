import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/domain/entities/workflow/post.dart';
import 'package:lomba_frontend/domain/entities/workflow/textcontent.dart';

import '../../../core/failures.dart';
import '../../repositories/post_repository.dart';

class AddTextPost {
  final PostRepository repository;
  AddTextPost(this.repository);
  Future<Either<Failure, Post>> execute(
    String orgaId, String userId, TextContent text, String title, String flowId, bool isDraft)
    async{
    return await repository.addTextPost(orgaId, userId, text, title, flowId, isDraft );
    }
}