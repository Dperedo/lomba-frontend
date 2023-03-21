import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/entities/workflow/post.dart';

///Interfaz de los estados de Home.
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

///Estado de Home que sabe si el usuario está logueado o no.
class HomeLoaded extends HomeState {
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
  const HomeLoaded(
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

  //const HomeLoaded(this.validLogin);
}

///Estado inicial del Home
class HomeStart extends HomeState {
  final String message;
  const HomeStart(this.message);
}

///Estado que indica que la información se está cargando.
///
///Este estado sirve para mostrar el spinner (círculo que gira) mientras
///el trabajo se está realizando.
class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}

class HomeOnlyUser extends HomeState {}

class HomeHasLoginGoogleRedirect extends HomeState {}
