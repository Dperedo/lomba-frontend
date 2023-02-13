import 'package:equatable/equatable.dart';

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
