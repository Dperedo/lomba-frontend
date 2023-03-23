import 'package:equatable/equatable.dart';

///Interfaz del evento de controla la página principal.
abstract class RecentEvent extends Equatable {
  const RecentEvent();
}

///Evento que ocurre cuando se comienza a cargar la página de Recent.
class OnRecentLoading extends RecentEvent {
  final String searchText;
  final Map<String, int> fieldsOrder;
  final int pageIndex;
  final int pageSize;

  const OnRecentLoading(
      this.searchText, this.fieldsOrder, this.pageIndex, this.pageSize);

  @override
  List<Object> get props => [searchText, fieldsOrder, pageIndex, pageSize];
}

///Evento ocurre cuando la página de Recent ya fue cargada
class OnRecentLoaded extends RecentEvent {
  const OnRecentLoaded();

  @override
  List<Object?> get props => [];
}

///Evento ocurre cuando se va a reiniciar el Recent provocando la recarga
class OnRecentStarter extends RecentEvent {
  final String message;
  const OnRecentStarter(this.message);
  @override
  List<Object?> get props => [message];
}

class OnRecentVote extends RecentEvent {
  final String postId;
  final int voteValue;

  const OnRecentVote(this.postId, this.voteValue);

  @override
  List<Object> get props => [postId, voteValue];
}
