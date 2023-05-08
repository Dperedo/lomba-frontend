import 'package:equatable/equatable.dart';
import 'package:lomba_frontend/domain/entities/workflow/textcontent.dart';

import '../../../domain/entities/workflow/imagecontent.dart';
import '../../../domain/entities/workflow/post.dart';
import '../../../domain/entities/workflow/stage.dart';
import '../../../domain/entities/workflow/videocontent.dart';

///Interfaz del evento de controla la página principal.
abstract class DetailedListEvent extends Equatable {
  const DetailedListEvent();
}

///Evento que ocurre cuando se comienza a cargar la página de DetailedList.
class OnDetailedListLoading extends DetailedListEvent {
  final String searchText;
  final String flowId;
  final String stageId;
  final Map<String, int> fieldsOrder;
  final int pageIndex;
  final int pageSize;
  final bool enabled;
  final bool disabled;

  const OnDetailedListLoading(
      this.searchText,
      this.flowId,
      this.stageId,
      this.fieldsOrder,
      this.pageIndex,
      this.pageSize,
      this.enabled,
      this.disabled);

  @override
  List<Object> get props => [
        searchText,
        flowId,
        stageId,
        fieldsOrder,
        pageIndex,
        pageSize,
        enabled,
        disabled
      ];
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

class OnDetailedListEdit extends DetailedListEvent {
  final Post post;

  const OnDetailedListEdit(this.post);

  @override
  List<Object> get props => [post];
}

class OnDetailedListEnable extends DetailedListEvent {
  final Post post;
  final List<Stage> listStage;

  const OnDetailedListEnable(this.post, this.listStage);

  @override
  List<Object> get props => [post, listStage];
}

class OnDetailedListChangeStage extends DetailedListEvent {
  final Post post;
  final String stageId;
  final List<Stage> listStage;
  const OnDetailedListChangeStage(this.post, this.stageId, this.listStage);

  @override
  List<Object> get props => [post, stageId, listStage];
}

class OnDetailedListPrepareEditContent extends DetailedListEvent {
  final Post post;
  const OnDetailedListPrepareEditContent(this.post);
  @override
  List<Object> get props => [post];
}

class OnDetailedListEditContent extends DetailedListEvent {
  final String postId;
  final String userId;
  final String title;
  final TextContent? textContent;
  final ImageContent? imageContent;
  final VideoContent? videoContent;
  const OnDetailedListEditContent(this.postId, this.userId, this.title,
      this.textContent, this.imageContent, this.videoContent);
  @override
  List<Object> get props =>
      [postId, userId, title, textContent!, imageContent!, videoContent!];
}
