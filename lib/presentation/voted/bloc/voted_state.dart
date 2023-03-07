
import 'package:equatable/equatable.dart';

import '../../../domain/entities/workflow/post.dart';

abstract class VotedState extends Equatable {
  VotedState();
Map<String, int> votes = <String, int>{};
  @override
  List<Object> get props => [];
}

class VotedStart extends VotedState {}

class VotedLoading extends VotedState {}

class VotedLoaded extends VotedState {
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

  VotedLoaded(
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

class VotedError extends VotedState {
  final String message;

  VotedError(this.message);

  @override
  List<Object> get props => [message];
}
