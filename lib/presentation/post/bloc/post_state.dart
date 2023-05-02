import 'package:equatable/equatable.dart';
import 'package:lomba_frontend/domain/entities/workflow/post.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostStart extends PostState {
  final String message;
  final String postId;

  const PostStart(this.message,  this.postId);

  @override
  List<Object> get props => [message, postId];
}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final Post post;
  final bool validLogin;
  const PostLoaded(this.post, this.validLogin);
  @override
  List<Object> get props => [post, validLogin];
}

class PostError extends PostState {
  final String message;

  const PostError(this.message);

  @override
  List<Object> get props => [message];
}