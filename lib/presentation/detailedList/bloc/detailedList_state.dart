import 'package:equatable/equatable.dart';
import 'package:lomba_frontend/domain/entities/workflow/stage.dart';

import '../../../domain/entities/workflow/post.dart';

///Interfaz de los estados de DetailedList.
abstract class DetailedListState extends Equatable {
  const DetailedListState();

  @override
  List<Object> get props => [];
}

///Estado de DetailedList que sabe si el usuario está logueado o no.
class DetailedListLoaded extends DetailedListState {
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
  const DetailedListLoaded(
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

  //const DetailedListLoaded(this.validLogin);
}

///Estado inicial del DetailedList
class DetailedListStart extends DetailedListState {
  const DetailedListStart();
}

///Estado que indica que la información se está cargando.
///
///Este estado sirve para mostrar el spinner (círculo que gira) mientras
///el trabajo se está realizando.
class DetailedListLoading extends DetailedListState {}

class DetailedListError extends DetailedListState {
  final String message;

  const DetailedListError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailedListEdit extends DetailedListState {
  final Post post;
  final List<Stage> liststage;

  const DetailedListEdit(this.post, this.liststage);

  @override
  List<Object> get props => [post,liststage];
}

class DetailedListOnlyUser extends DetailedListState {}
