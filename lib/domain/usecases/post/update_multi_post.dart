import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/domain/entities/workflow/post.dart';
import 'package:lomba_frontend/domain/entities/workflow/textcontent.dart';

import '../../../core/failures.dart';
import '../../entities/workflow/imagecontent.dart';
import '../../entities/workflow/videocontent.dart';
import '../../repositories/post_repository.dart';

class UpdateMultiPost {
  final PostRepository repository;
  UpdateMultiPost(this.repository);
  Future<Either<Failure, Post>> execute(
      String postId,
      String userId,
      TextContent? text,
      ImageContent? image,
      VideoContent? video,
      String title) async {
    return await repository.updateMultiPost(
        postId, userId, text, image, video, title);
  }
}
