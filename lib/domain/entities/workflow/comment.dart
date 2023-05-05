import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  const Comment({required this.id, required this.userId, required this.postId, required this.text, required this.enabled});

  final String id;
  final String userId;
  final String postId;
  final String text;
  final bool enabled;

  @override
  List<Object> get props => [id, userId, postId, text, enabled];
}

