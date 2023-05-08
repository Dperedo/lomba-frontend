import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
  @override
  List<Object> get props => [];
}

class OnPostStarter extends PostEvent {
  final String postId;

  const OnPostStarter(this.postId);

  @override
  List<Object> get props => [postId];
}

class OnPostLoad extends PostEvent {
  final String postId;

  const OnPostLoad(this.postId);

  @override
  List<Object> get props => [postId];
}

class OnPostVote extends PostEvent {
  final String postId;
  final int voteValue;

  const OnPostVote(this.postId, this.voteValue);

  @override
  List<Object> get props => [postId, voteValue];
}

class OnCreateComment extends PostEvent {
  final String userId;
  final String postId;
  final String text;

  const OnCreateComment(this.userId, this.postId, this.text);

  @override
  List<Object> get props => [userId, postId, text];
}