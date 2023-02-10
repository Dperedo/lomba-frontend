import 'package:equatable/equatable.dart';

import '../../../domain/entities/flows/post.dart';

abstract class PopularState extends Equatable {
  const PopularState();

  @override
  List<Object> get props => [];
}
class PopularStart extends PopularState {}

class PopularLoading extends PopularState {}

class PopularError extends PopularState {
  final String message;

  const PopularError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularLoaded extends PopularState{
  final bool validLogin;
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
  const PopularLoaded(
      this.validLogin,
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