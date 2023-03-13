import 'package:equatable/equatable.dart';

import '../../../domain/entities/workflow/post.dart';

///Interfaz del evento de controla la página principal.
abstract class DetailedListEvent extends Equatable {
  const DetailedListEvent();
}

///Evento que ocurre cuando se comienza a cargar la página de DetailedList.
class OnDetailedListLoading extends DetailedListEvent {
  final String searchText;
  final Map<String, int> fieldsOrder;
  final int pageIndex;
  final int pageSize;

  const OnDetailedListLoading(
      this.searchText, this.fieldsOrder, this.pageIndex, this.pageSize);

  @override
  List<Object> get props => [searchText, fieldsOrder, pageIndex, pageSize];
}

///Evento ocurre cuando la página de DetailedList ya fue cargada
class OnDetailedListLoaded extends DetailedListEvent {
  const OnDetailedListLoaded();

  @override
  List<Object?> get props => [];
}

///Evento ocurre cuando se va a reiniciar el DetailedList provocando la recarga
class OnDetailedListStarter extends DetailedListEvent {
  final String message;
  const OnDetailedListStarter(this.message);
  @override
  List<Object?> get props => [message];
}

class OnDetailedListVote extends DetailedListEvent {
  final String postId;
  final int voteValue;

  const OnDetailedListVote(this.postId, this.voteValue);

  @override
  List<Object> get props => [postId, voteValue];
}

class OnDetailedListEdit extends DetailedListEvent{
  final Post post;

  const OnDetailedListEdit(this.post);

  
  @override
  List<Object> get props => [post];
}

class OnDetailedListEnable extends DetailedListEvent{
  const OnDetailedListEnable();

  @override
  List<Object> get props => [];
}
