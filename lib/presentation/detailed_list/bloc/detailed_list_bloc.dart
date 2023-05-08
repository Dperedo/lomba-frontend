import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/entities/workflow/stage.dart';
import 'package:lomba_frontend/domain/usecases/local/get_session_role.dart';
import 'package:lomba_frontend/domain/usecases/local/get_session_status.dart';
import 'package:lomba_frontend/domain/usecases/post/update_multi_post.dart';
import 'package:lomba_frontend/domain/usecases/post/vote_publication.dart';
import 'package:lomba_frontend/domain/usecases/stage/get_stages.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/constants.dart';
import '../../../data/models/session_model.dart';
import '../../../domain/entities/workflow/flow.dart';
import '../../../domain/entities/workflow/post.dart';
import '../../../domain/entities/workflow/textcontent.dart';
import '../../../domain/usecases/flow/get_flows.dart';
import '../../../domain/usecases/post/change_stage_post.dart';
import '../../../domain/usecases/post/enable_post.dart';
import '../../../domain/usecases/post/get_detailedlist_posts.dart';
import '../../../domain/usecases/users/get_user.dart';
import 'detailed_list_event.dart';
import 'detailed_list_state.dart';

///BLOC para el control de la página principal o DetailedList
///
///Consulta si el usuario está logueado o no.
class DetailedListBloc extends Bloc<DetailedListEvent, DetailedListState> {
  final GetSession _getSession;
  final GetDetailedListPosts _getDetailedListPosts;
  final VotePublication _votePublication;
  final GetSessionRole _getSessionRole;
  final GetStages _getStages;
  final GetFlows _getFlows;
  final ChangeStagePost _changeStagePost;
  final EnablePost _enablePost;
  final UpdateMultiPost _updateMultiPost;
  final GetUser _getUser;

  DetailedListBloc(
      this._getSession,
      this._getDetailedListPosts,
      this._votePublication,
      this._getSessionRole,
      this._getStages,
      this._getFlows,
      this._changeStagePost,
      this._enablePost,
      this._updateMultiPost,
      this._getUser)
      : super(const DetailedListStart()) {
    ///Evento que hace la consulta de sesión del usuario en el dispositivo.
    on<OnDetailedListLoading>(
      (event, emit) async {
        emit(DetailedListLoading());
        var auth = const SessionModel(token: "", username: "", name: "");
        String flowId = event.flowId;
        String stageId = event.stageId;
        String role = '';
        List<Flow> listFlows = [
          Flow(
              id: '',
              name: 'Todos los Flujos',
              enabled: true,
              builtIn: true,
              created: DateTime.now(),
              stages: const [],
              updated: null,
              deleted: null,
              expires: null)
        ];
        List<Stage> listStages = [
          Stage(
              id: '',
              name: 'Todas las Etapas',
              order: 2,
              queryOut: null,
              enabled: true,
              builtIn: true,
              created: DateTime.now(),
              updated: null,
              deleted: null,
              expires: null)
        ];
        var validLogin = false;

        final listroles = await _getSessionRole.execute();
        listroles.fold(
            (l) => emit(DetailedListError(l.message)), (r) => {role = r[0]});

        final session = await _getSession.execute();
        session.fold(
            (l) => emit(DetailedListError(l.message)), (r) => {auth = r});
        final resultGetFlows = await _getFlows.execute();
        resultGetFlows.fold(
            (l) => emit(DetailedListError(l.message)),
            (r) => {
                  for (var item in r) {listFlows.add(item)}
                });
        final resultGetStages = await _getStages.execute();
        resultGetStages.fold(
            (l) => emit(DetailedListError(l.message)),
            (r) => {
                  for (var item in r) {listStages.add(item)}
                });
        int enableValue = 0;
        if (event.enabled) {
          enableValue = 1;
        } else if (event.disabled) {
          enableValue = -1;
        }

        final resultPosts = await _getDetailedListPosts.execute(
            auth.getOrgaId()!,
            auth.getUserId()!,
            flowId,
            event.stageId,
            event.searchText,
            event.fieldsOrder,
            event.pageIndex,
            event.pageSize,
            enableValue);
        resultPosts.fold(
            (l) => {emit(DetailedListError(l.message))},
            (r) => emit(DetailedListLoaded(
                validLogin,
                auth.getOrgaId()!,
                auth.getUserId()!,
                flowId,
                event.stageId,
                event.searchText,
                event.fieldsOrder,
                event.pageIndex,
                event.pageSize,
                r.items,
                r.currentItemCount,
                r.totalItems ?? 0,
                r.totalPages ?? 1,
                listFlows,
                listStages)));
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    ///Evento es llamado para reiniciar el DetailedList y haga la consulta de sesión.
    on<OnDetailedListStarter>((event, emit) async {
      emit(const DetailedListStart());
    });

    on<OnDetailedListEdit>((event, emit) async {
      emit(DetailedListLoading());

      String name = '';
      String username = '';

      final resultUser = await _getUser.execute(event.post.userId);
      resultUser.fold((l) => emit(DetailedListError(l.message)), (r) {
        name = r.name;
        username = r.username;
      });

      final resultStage = await _getStages.execute();
      resultStage.fold((l) => emit(DetailedListError(l.message)),
          (r) => emit(DetailedListEdit(event.post, r, name, username)));
    });

    on<OnDetailedListPrepareEditContent>((event, emit) async {
      emit(DetailedListEditContent(event.post));
    });

    on<OnDetailedListEditContent>((event, emit) async {
      emit(DetailedListLoading());
      List<Stage> listStage = [];

      String name = '';
      String username = '';

      final resultUser = await _getUser.execute(event.userId);
      resultUser.fold((l) => emit(DetailedListError(l.message)), (r) {
        name = r.name;
        username = r.username;
      });

      final resultStage = await _getStages.execute();
      resultStage.fold(
          (l) => emit(DetailedListError(l.message)), (r) => listStage = r);

      final resultUpdate = await _updateMultiPost.execute(
          event.postId,
          event.userId,
          event.textContent,
          event.imageContent,
          event.videoContent,
          event.title);
      resultUpdate.fold((l) => emit(DetailedListError(l.message)),
          (r) => emit(DetailedListEdit(r, listStage, name, username)));
    });

    on<OnDetailedListChangeStage>((event, emit) async {
      emit(DetailedListLoading());

      String name = '';
      String username = '';

      final resultUser = await _getUser.execute(event.post.userId);
      resultUser.fold((l) => emit(DetailedListError(l.message)), (r) {
        name = r.name;
        username = r.username;
      });

      final editStage = await _changeStagePost.execute(
          event.post.id, event.post.flowId, event.stageId);
      editStage.fold(
          (l) => emit(DetailedListError(l.message)),
          (post) =>
              emit(DetailedListEdit(post, event.listStage, name, username)));
    });

    on<OnDetailedListEnable>((event, emit) async {
      emit(DetailedListLoading());

      Post post = event.post;

      String name = '';
      String username = '';

      final resultUser = await _getUser.execute(event.post.userId);
      resultUser.fold((l) => emit(DetailedListError(l.message)), (r) {
        name = r.name;
        username = r.username;
      });

      final editStage = await _enablePost.execute(post.id, !post.enabled);
      editStage.fold((l) {
        if (l.message == 'No fue posible realizar la acción') {
          emit(DetailedListError(l.message));
          emit(DetailedListEdit(post, event.listStage, name, username));
        } else {
          emit(DetailedListError(l.message));
        }
      }, (r) => emit(DetailedListEdit(r, event.listStage, name, username)));
    });

    on<OnDetailedListVote>((event, emit) async {
      String flowId = Flows.votationFlowId;
      String stageId = StagesVotationFlow.stageId03Voting;
      var auth = const SessionModel(token: "", username: "", name: "");
      final session = await _getSession.execute();
      session.fold(
          (l) => emit(DetailedListError(l.message)), (r) => {auth = r});

      final result = await _votePublication.execute(auth.getOrgaId()!,
          auth.getUserId()!, flowId, stageId, event.postId, event.voteValue);
      result.fold((l) => emit(DetailedListError(l.message)), (r) {
        emit(const DetailedListStart());
      });
    });
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
