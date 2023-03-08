import 'package:equatable/equatable.dart';

abstract class ApprovedEvent extends Equatable {
  const ApprovedEvent();

  @override
  List<Object?> get props => [];
}

class OnApprovedLoad extends ApprovedEvent {
  final String searchText;
  final Map<String, int> fieldsOrder;
  final int pageIndex;
  final int pageSize;

  const OnApprovedLoad(
      this.searchText, this.fieldsOrder, this.pageIndex, this.pageSize);

  @override
  List<Object> get props => [searchText, fieldsOrder, pageIndex, pageSize];
}

class OnApprovedVote extends ApprovedEvent {
  final String postId;
  final int voteValue;

  const OnApprovedVote(this.postId, this.voteValue);

  @override
  List<Object> get props => [postId, voteValue];
}

class OnApprovedStarter extends ApprovedEvent {}
