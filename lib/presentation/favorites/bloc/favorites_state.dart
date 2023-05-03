
import 'package:equatable/equatable.dart';

import '../../../domain/entities/workflow/post.dart';

abstract class FavoritesState extends Equatable {
  FavoritesState();
Map<String, int> votes = <String, int>{};
  @override
  List<Object> get props => [];
}

class FavoritesStart extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final String orgaId;
  final String userId;
  final String flowId;
  final String stageId;
  final bool positive;
  final String searchText;
  final Map<String, int> fieldsOrder;
  final int pageIndex;
  final int pageSize;
  final List<Post> listItems;
  final int itemCount;
  final int totalItems;
  final int totalPages;

  FavoritesLoaded(
      this.orgaId,
      this.userId,
      this.flowId,
      this.stageId,
      this.positive,
      this.searchText,
      this.fieldsOrder,
      this.pageIndex,
      this.pageSize,
      this.listItems,
      this.itemCount,
      this.totalItems,
      this.totalPages);
}

class FavoritesError extends FavoritesState {
  final String message;

  FavoritesError(this.message);

  @override
  List<Object> get props => [message];
}
