import 'package:equatable/equatable.dart';

import '../../../domain/entities/flows/post.dart';

abstract class VotedState extends Equatable {
  const VotedState();

  @override
  List<Object> get props => [];
}
class VotedStart extends VotedState {}

class VotedLoading extends VotedState {}

class VotedLoaded extends VotedState{
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
  
  const VotedLoaded(
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

class VotedError extends VotedState {
  final String message;

  const VotedError(this.message);

  @override
  List<Object> get props => [message];
}