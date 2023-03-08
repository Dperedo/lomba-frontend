import 'package:equatable/equatable.dart';

///Interfaz del evento de controla la página principal.
abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

///Evento que ocurre cuando se comienza a cargar la página de Home.
class OnHomeLoading extends HomeEvent {
  final String searchText;
  final Map<String, int> fieldsOrder;
  final int pageIndex;
  final int pageSize;

  const OnHomeLoading(
      this.searchText, this.fieldsOrder, this.pageIndex, this.pageSize);

  @override
  List<Object> get props => [searchText, fieldsOrder, pageIndex, pageSize];
}

///Evento ocurre cuando la página de Home ya fue cargada
class OnHomeLoaded extends HomeEvent {
  const OnHomeLoaded();

  @override
  List<Object?> get props => [];
}

///Evento ocurre cuando se va a reiniciar el Home provocando la recarga
class OnHomeStarter extends HomeEvent {
  final String message;
  const OnHomeStarter(this.message);
  @override
  List<Object?> get props => [message];
}

class OnHomeVote extends HomeEvent {
  final String postId;
  final int voteValue;

  const OnHomeVote(this.postId, this.voteValue);

  @override
  List<Object> get props => [postId, voteValue];
}
