import 'package:equatable/equatable.dart';

import '../user.dart';

class Comment extends Equatable {
  const Comment({
    required this.id,
    required this.userId,
    required this.postId,
    required this.text,
    required this.users,
    required this.enabled,
    required this.created,});

  final String id;
  final String userId;
  final String postId;
  final String text;
  final List<User> users;
  final bool enabled;
  final DateTime created;

  @override
  List<Object> get props => [id, userId, postId, text, users, enabled, created];
}

