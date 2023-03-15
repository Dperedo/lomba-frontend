import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/entities/workflow/stage.dart';
import 'package:lomba_frontend/domain/usecases/local/get_session_role.dart';
import 'package:lomba_frontend/domain/usecases/local/get_session_status.dart';
import 'package:lomba_frontend/domain/usecases/post/vote_publication.dart';
import 'package:lomba_frontend/domain/usecases/stage/get_stage.dart';
import 'package:lomba_frontend/domain/usecases/stage/get_stages.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/constants.dart';
import '../../../data/models/session_model.dart';
import '../../../domain/entities/workflow/flow.dart';
import '../../../domain/usecases/flow/get_flows.dart';
import '../../../domain/usecases/post/get_detailedlist_posts.dart';
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

  DetailedListBloc(
    this._getSession,
    this._getDetailedListPosts,
    this._votePublication,
    this._getSessionRole,
    this._getStages,
    this._getFlows)
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
            created: DateTime.parse('2023-02-17 19:16:08.700Z'),
            stages: const [],
            updated: null,
            deleted: null,
            expires: null
          )
        ];
        List<Stage> listStages = [
          Stage(
            id: '',
            name: 'Todos los estados',
            order: 2,
            queryOut: null,
            enabled: true,
            builtIn: true,
            created: DateTime.parse('2023-02-17 19:16:08.700Z'),
            updated: null,
            deleted: null,
            expires: null
          )
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
            (l) => emit(DetailedListError(l.message)), (r) =>
            {for(var item in r) {listFlows.add(item)}});
        final resultGetStages = await _getStages.execute();
        resultGetStages.fold(
            (l) => emit(DetailedListError(l.message)), (r) => 
            {for(var item in r) {listStages.add(item)}});
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
            stageId,
            event.searchText,
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
                stageId,
                event.searchText,
                event.fieldsOrder,
                event.pageIndex,
                event.pageSize,
                r.items,
                r.currentItemCount,
                r.items.length,
                r.items.length,
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

      final resultStage = await _getStages.execute();
      resultStage.fold((l) => emit(DetailedListError(l.message)),
          (r) => emit(DetailedListEdit(event.post, r)));
      //emit(DetailedListEdit(event.post, []));
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
