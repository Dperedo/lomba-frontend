import 'package:equatable/equatable.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class OnFavoritesLoad extends FavoritesEvent {
  final String searchText;
  final Map<String, int> fieldsOrder;
  final int pageIndex;
  final int pageSize;
  final bool positive;
  final bool negative;

  const OnFavoritesLoad(this.searchText, this.fieldsOrder, this.pageIndex,
      this.pageSize, this.positive, this.negative);

  @override
  List<Object> get props =>
      [searchText, fieldsOrder, pageIndex, pageSize, positive, negative];
}

class OnFavoritesAddVote extends FavoritesEvent {
  final String postId;
  final int voteValue;

  const OnFavoritesAddVote(this.postId, this.voteValue);

  @override
  List<Object> get props => [postId, voteValue];
}

class OnFavoritesStarter extends FavoritesEvent {}
