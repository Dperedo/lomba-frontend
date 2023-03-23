import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/entities/workflow/post.dart';

///Interfaz de los estados de Recent.
abstract class RecentState extends Equatable {
  const RecentState();

  @override
  List<Object> get props => [];
}

///Estado de Recent que sabe si el usuario está logueado o no.
class RecentLoaded extends RecentState {
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
  const RecentLoaded(
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

  //const RecentLoaded(this.validLogin);
}

///Estado inicial del Recent
class RecentStart extends RecentState {
  final String message;
  const RecentStart(this.message);
}

///Estado que indica que la información se está cargando.
///
///Este estado sirve para mostrar el spinner (círculo que gira) mientras
///el trabajo se está realizando.
class RecentLoading extends RecentState {}

class RecentError extends RecentState {
  final String message;

  const RecentError(this.message);

  @override
  List<Object> get props => [message];
}

class RecentOnlyUser extends RecentState {}

class RecentHasLoginGoogleRedirect extends RecentState {}
