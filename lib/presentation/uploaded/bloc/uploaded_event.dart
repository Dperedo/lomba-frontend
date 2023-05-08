import 'package:equatable/equatable.dart';

import '../../../domain/entities/workflow/imagecontent.dart';
import '../../../domain/entities/workflow/post.dart';
import '../../../domain/entities/workflow/textcontent.dart';
import '../../../domain/entities/workflow/videocontent.dart';

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
  final TextContent? textContent;
  final ImageContent? imageContent;
  final VideoContent? videoContent;
  const OnUploadedEdit(this.postId, this.title, this.textContent,
      this.imageContent, this.videoContent);

  @override
  List<Object> get props => [title, textContent!, imageContent!, videoContent!];
}

class OnUploadedPrepareForEdit extends UploadedEvent {
  final Post post;
  const OnUploadedPrepareForEdit(this.post);

  @override
  List<Object> get props => [post];
}

class OnUploadedDelete extends UploadedEvent {
  final String postId;
  const OnUploadedDelete(this.postId);

  @override
  List<Object> get props => [postId];
}

class OnUploadedStarter extends UploadedEvent {}
