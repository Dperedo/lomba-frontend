import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/local/get_session_role.dart';
import 'package:lomba_frontend/domain/usecases/local/get_session_status.dart';
import 'package:lomba_frontend/domain/usecases/post/vote_publication.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/constants.dart';
import '../../../data/models/session_model.dart';
import '../../../domain/usecases/post/get_detailedlist_posts.dart';
import 'detailedList_event.dart';
import 'detailedList_state.dart';

///BLOC para el control de la página principal o DetailedList
///
///Consulta si el usuario está logueado o no.
class DetailedListBloc extends Bloc<DetailedListEvent, DetailedListState> {
  final GetSession _getSession;
  final GetDetailedListPosts _getDetailedListPosts;
  final VotePublication _votePublication;
  final GetSessionRole _getSessionRole;

  DetailedListBloc(this._getSession,
      this._getDetailedListPosts, this._votePublication, this._getSessionRole)
      : super(const DetailedListStart()) {
    ///Evento que hace la consulta de sesión del usuario en el dispositivo.
    on<OnDetailedListLoading>(
      (event, emit) async {
        emit(DetailedListLoading());
        var auth = const SessionModel(token: "", username: "", name: "");
        String flowId = Flows.votationFlowId;
        String stageId = StagesVotationFlow.stageId03Voting;
        String role = '';
        var validLogin = false;
        
        final listroles = await _getSessionRole.execute();
        listroles.fold(
            (l) => emit(DetailedListError(l.message)), (r) => {role = r[0]});

        final session = await _getSession.execute();
        session.fold((l) => emit(DetailedListError(l.message)), (r) => {auth = r});

        final resultPosts = await _getDetailedListPosts.execute(
            auth.getOrgaId()!,
            auth.getUserId()!,
            flowId,
            stageId,
            event.searchText,
            event.pageIndex,
            event.pageSize);
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
                r.items.length)));

        
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    ///Evento es llamado para reiniciar el DetailedList y haga la consulta de sesión.
    on<OnDetailedListStarter>((event, emit) async {
      emit(const DetailedListStart());
    });

    on<OnDetailedListEdit>((event, emit) async {
      emit(DetailedListEdit(event.post));
    });

    on<OnDetailedListVote>((event, emit) async {
      String flowId = Flows.votationFlowId;
      String stageId = StagesVotationFlow.stageId03Voting;
      var auth = const SessionModel(token: "", username: "", name: "");
      final session = await _getSession.execute();
      session.fold((l) => emit(DetailedListError(l.message)), (r) => {auth = r});

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
