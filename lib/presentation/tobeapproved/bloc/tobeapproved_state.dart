import 'package:equatable/equatable.dart';

import '../../../domain/entities/flows/post.dart';

abstract class ToBeApprovedState extends Equatable {
  const ToBeApprovedState();

  @override
  List<Object> get props => [];
}
class ToBeApprovedStart extends ToBeApprovedState {}

class ToBeApprovedLoading extends ToBeApprovedState {}

class ToBeApprovedError extends ToBeApprovedState {
  final String message;

  const ToBeApprovedError(this.message);

  @override
  List<Object> get props => [message];
}

class ToBeApprovedLoaded extends ToBeApprovedState{
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
  const ToBeApprovedLoaded(
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
      this.totalPages);
}