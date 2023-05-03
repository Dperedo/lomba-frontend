
import 'package:equatable/equatable.dart';

import '../../../domain/entities/workflow/post.dart';

abstract class SavedState extends Equatable {
  SavedState();
Map<String, int> votes = <String, int>{};
  @override
  List<Object> get props => [];
}

class SavedStart extends SavedState {}

class SavedLoading extends SavedState {}

class SavedLoaded extends SavedState {
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

  SavedLoaded(
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

class SavedError extends SavedState {
  final String message;

  SavedError(this.message);

  @override
  List<Object> get props => [message];
}