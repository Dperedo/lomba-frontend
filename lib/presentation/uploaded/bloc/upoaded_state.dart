import 'package:equatable/equatable.dart';
import 'package:lomba_frontend/domain/entities/flows/post.dart';

import '../../../core/fakedata.dart';

abstract class UploadedState extends Equatable {
  const UploadedState();

  @override
  List<Object> get props => [];
}

class UploadedStart extends UploadedState {}

class UploadedLoading extends UploadedState {}

class UploadedLoaded extends UploadedState {
  final String orgaId;
  final String userId;
  final String flowId;
  final String stageId;
  final bool onlyDrafts;
  final String searchText;
  final Map<String, int> fieldsOrder;
  final int pageIndex;
  final int pageSize;
  final List<Post> listItems;
  final int itemCount;
  final int totalItems;
  final int totalPages;
  const UploadedLoaded(
      this.orgaId,
      this.userId,
      this.flowId,
      this.stageId,
      this.onlyDrafts,
      this.searchText,
      this.fieldsOrder,
      this.pageIndex,
      this.pageSize,
      this.listItems,
      this.itemCount,
      this.totalItems,
      this.totalPages);
}

class UploadedError extends UploadedState {
  final String message;

  const UploadedError(this.message);

  @override
  List<Object> get props => [message];
}
