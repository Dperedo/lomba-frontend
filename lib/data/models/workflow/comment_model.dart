import '../../../domain/entities/workflow/comment.dart';

class CommentModel extends Comment {
  const CommentModel({required id, required userId, required postId, required text, required enabled, required created})
      : super(id: id, userId: userId, postId: postId, text: text, enabled: enabled, created: created);

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json["id"],
      userId: json["userId"],
      postId: json["postId"],
      text: json["text"],
      enabled: json["enabled"],
      created: json["created"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'postId': postId,
      'text': text,
      'enabled': enabled,
      'created': created,
    };
  }

  Comment toEntity() => Comment(
        id: id,
        userId: userId,
        postId: postId,
        text: text,
        enabled: enabled,
        created: created,
      );

  @override
  List<Object> get props => [id, userId, postId, text, enabled, created];
}
