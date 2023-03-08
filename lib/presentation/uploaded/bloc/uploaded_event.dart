import 'package:equatable/equatable.dart';

import '../../../domain/entities/workflow/post.dart';

abstract class UploadedEvent extends Equatable {
  const UploadedEvent();

  @override
  List<Object?> get props => [];
}

class OnUploadedLoad extends UploadedEvent {
  final String searchText;
  final Map<String, int> fieldsOrder;
  final int pageIndex;
  final int pageSize;
  final bool onlydrafts;

  const OnUploadedLoad(this.searchText, this.fieldsOrder, this.pageIndex,
      this.pageSize, this.onlydrafts);

  @override
  List<Object> get props =>
      [searchText, fieldsOrder, pageIndex, pageSize, onlydrafts];
}

class OnUploadedVote extends UploadedEvent {
  final String postId;
  final int voteValue;

  const OnUploadedVote(this.postId, this.voteValue);

  @override
  List<Object> get props => [postId, voteValue];
}

class OnUploadedEdit extends UploadedEvent {
  final String postId;
  final String title;
  final String content;
  const OnUploadedEdit(this.postId, this.title, this.content);

  @override
  List<Object> get props => [title, content];
}

class OnUploadedPrepareForEdit extends UploadedEvent {
  final String postId;
  final String title;
  final String content;
  const OnUploadedPrepareForEdit(this.postId, this.title, this.content);

  @override
  List<Object> get props => [postId, title, content];
}

class OnUploadedDelete extends UploadedEvent {
  final String postId;
  const OnUploadedDelete(this.postId);

  @override
  List<Object> get props => [postId];
}

class OnUploadedStarter extends UploadedEvent {}
