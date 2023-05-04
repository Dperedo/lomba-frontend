import 'package:equatable/equatable.dart';

class Bookmark extends Equatable {
  const Bookmark({required this.userId, required this.postId, required this.markType, required this.enabled});

  final String userId;
  final String postId;
  final String markType;
  final bool enabled;

  @override
  List<Object> get props => [userId, postId, markType, enabled];
}

