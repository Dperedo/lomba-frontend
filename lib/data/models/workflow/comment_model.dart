import '../../../domain/entities/workflow/comment.dart';

class CommentModel extends Comment {
  const CommentModel({required id, required userId, required postId, required text, required enabled})
      : super(id: id, userId: userId, postId: postId, text: text, enabled: enabled);

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json["id"],
      userId: json["userId"],
      postId: json["postId"],
      text: json["text"],
      enabled: json["enabled"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'postId': postId,
      'text': text,
      'enabled': enabled,
    };
  }

  Comment toEntity() => Comment(
        id: id,
        userId: userId,
        postId: postId,
        text: text,
        enabled: enabled,
      );

  @override
  List<Object> get props => [id, userId, postId, text, enabled];
}
