import '../../../domain/entities/workflow/bookmark.dart';

class BookmarkModel extends Bookmark {
  const BookmarkModel({required userId, required postId, required markType, required enabled})
      : super(userId: userId, postId: postId, markType: markType, enabled: enabled);

  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
      userId: json["userId"],
      postId: json["postId"],
      markType: json["markType"],
      enabled: json["enabled"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'postId': postId,
      'markType': markType,
      'enabled': enabled,
    };
  }

  Bookmark toEntity() => Bookmark(
        userId: userId,
        postId: postId,
        markType: markType,
        enabled: enabled,
      );

  @override
  List<Object> get props => [userId, postId, markType, enabled];
}
