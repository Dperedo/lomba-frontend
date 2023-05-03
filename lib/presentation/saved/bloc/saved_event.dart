import 'package:equatable/equatable.dart';

abstract class SavedEvent extends Equatable {
  const SavedEvent();

  @override
  List<Object?> get props => [];
}

class OnSavedLoad extends SavedEvent {
  final String searchText;
  final Map<String, int> fieldsOrder;
  final int pageIndex;
  final int pageSize;
  final bool positive;
  final bool negative;

  const OnSavedLoad(this.searchText, this.fieldsOrder, this.pageIndex,
      this.pageSize, this.positive, this.negative);

  @override
  List<Object> get props =>
      [searchText, fieldsOrder, pageIndex, pageSize, positive, negative];
}

class OnSavedAddVote extends SavedEvent {
  final String postId;
  final int voteValue;

  const OnSavedAddVote(this.postId, this.voteValue);

  @override
  List<Object> get props => [postId, voteValue];
}

class OnSavedStarter extends SavedEvent {}
