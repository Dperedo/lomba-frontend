import 'package:equatable/equatable.dart';

import '../../../domain/entities/workflow/post.dart';

abstract class RejectedState extends Equatable {
  const RejectedState();

  @override
  List<Object> get props => [];
}
class RejectedStart extends RejectedState {}

class RejectedLoading extends RejectedState {}

class RejectedLoaded extends RejectedState{
  final String orgaId;
  final String userId;
  final String flowId;
  final String stageId;  
  final String searchText;
  final Map<String, int> fieldsOrder;
  final int pageIndex;
  final int pageSize;
  final List<Post> listItems;
  final int itemCount;
  final int totalItems;
  final int totalPages;
  
  const RejectedLoaded(
      this.orgaId,
      this.userId,
      this.flowId,
      this.stageId,      
      this.searchText,
      this.fieldsOrder,
      this.pageIndex,
      this.pageSize,
      this.listItems,
      this.itemCount,
      this.totalItems,
      this.totalPages,
      );
}

class RejectedError extends RejectedState {
  final String message;

  const RejectedError(this.message);

  @override
  List<Object> get props => [message];
}