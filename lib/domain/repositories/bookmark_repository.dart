import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../entities/workflow/bookmark.dart';

abstract class BookmarkRepository {
  Future<Either<Failure, Bookmark>> postBookmark(String userId, String postId, String markType, bool giveOrTakeAway);
}
