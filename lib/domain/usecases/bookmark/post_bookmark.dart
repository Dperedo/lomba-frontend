import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../entities/workflow/bookmark.dart';
import '../../repositories/bookmark_repository.dart';

class PostBookmark {
  final BookmarkRepository repository;
  PostBookmark(this.repository);
  Future<Either<Failure, Bookmark>> execute(String userId, String postId, String markType, bool giveOrTakeAway)
    async{
    return await repository.postBookmark(userId, postId, markType, giveOrTakeAway);
    }
}