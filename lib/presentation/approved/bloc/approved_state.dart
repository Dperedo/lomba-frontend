import 'package:equatable/equatable.dart';

import '../../../domain/entities/workflow/post.dart';

abstract class ApprovedState extends Equatable {
  const ApprovedState();

  @override
  List<Object> get props => [];
}
class ApprovedStart extends ApprovedState {}

class ApprovedLoading extends ApprovedState {}

class ApprovedLoaded extends ApprovedState{
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
  
  const ApprovedLoaded(
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

class ApprovedError extends ApprovedState {
  final String message;

  const ApprovedError(this.message);

  @override
  List<Object> get props => [message];
}
