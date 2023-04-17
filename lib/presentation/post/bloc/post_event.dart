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