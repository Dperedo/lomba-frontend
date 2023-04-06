import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/domain/entities/workflow/post.dart';
import 'package:lomba_frontend/domain/entities/workflow/textcontent.dart';

import '../../../core/failures.dart';
import '../../entities/workflow/imagecontent.dart';
import '../../entities/workflow/videocontent.dart';
import '../../repositories/post_repository.dart';

class AddMultiPost {
  final PostRepository repository;
  AddMultiPost(this.repository);
  Future<Either<Failure, Post>> execute(String orgaId, String userId, TextContent? text,
      ImageContent? image, VideoContent? video, String title, String flowId, bool isDraft)
    async{
    return await repository.addMultiPost(orgaId, userId, text,
      image, video, title, flowId, isDraft);
    }
}