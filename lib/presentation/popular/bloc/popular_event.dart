import 'package:equatable/equatable.dart';

abstract class PopularEvent extends Equatable {
  const PopularEvent();

  @override
  List<Object?> get props => [];
}

class OnPopularLoading extends PopularEvent {
  final String searchText;
  final Map<String, int> fieldsOrder;
  final int pageIndex;
  final int pageSize;

  const OnPopularLoading(
      this.searchText, this.fieldsOrder, this.pageIndex, this.pageSize);

  @override
  List<Object> get props => [searchText, fieldsOrder, pageIndex, pageSize];
}

class OnPopularVote extends PopularEvent {
  final String postId;
  final int voteValue;

  const OnPopularVote(this.postId, this.voteValue);

  @override
  List<Object> get props => [postId, voteValue];
}

class OnPopularStarter extends PopularEvent {}
