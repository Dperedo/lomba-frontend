import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/domain/entities/workflow/post.dart';
import 'package:lomba_frontend/domain/entities/workflow/textcontent.dart';

import '../../../core/failures.dart';
import '../../repositories/post_repository.dart';

class UpdateEdit {
  final PostRepository repository;
  UpdateEdit(this.repository);
  Future<Either<Failure, Post>> execute(
    String postId, String userId, TextContent text, String title)
    async{
    return await repository.updatePost(postId, userId, text, title);
    }
}