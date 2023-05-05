import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/post/get_uploaded_posts.dart';
import 'package:lomba_frontend/domain/usecases/post/vote_publication.dart';
import 'package:lomba_frontend/presentation/saved/bloc/saved_event.dart';
import 'package:lomba_frontend/presentation/saved/bloc/saved_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/constants.dart';
import '../../../data/models/session_model.dart';
import '../../../domain/usecases/local/get_has_login.dart';
import '../../../domain/usecases/local/get_session_status.dart';
import '../../../domain/usecases/post/get_saved_posts.dart';
import '../../../domain/usecases/post/get_voted_posts.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  final GetSavedPosts _getSavedPosts;
  final GetHasLogIn _hasLogin;
  final GetSession _getSession;
  final VotePublication _votePublication;
  final GetUploadedPosts _getUploadedPosts;

  SavedBloc(this._getSavedPosts, this._getSession, this._votePublication,
      this._getUploadedPosts, this._hasLogin)
      : super(SavedStart()) {
    on<OnSavedStarter>((event, emit) => emit(SavedStart()));

    on<OnSavedLoad>((event, emit) async {
      emit(SavedLoading());
      String flowId = Flows.votationFlowId;
      String stageId = StagesVotationFlow.stageId03Voting;
      var validLogin = false;

      final resultLogin = await _hasLogin.execute();
      resultLogin.fold((l) => {emit(SavedError(l.message))}, (valid) => {validLogin = valid});

      var auth = const SessionModel(token: "", username: "", name: "");
      final session = await _getSession.execute();
      session.fold((l) => emit(SavedError(l.message)), (r) => {auth = r});
      int voteValue = 0;
      if (event.positive) {
        voteValue = 1;
      } else if (event.negative) {
        voteValue = -1;
      }
      final result = await _getSavedPosts.execute(
        auth.getOrgaId()!,
        auth.getUserId()!,
        flowId,
        stageId,
        event.searchText,
        event.fieldsOrder,
        event.pageIndex,
        event.pageSize,
        voteValue,
      );
      result.fold((l) => {emit(SavedError(l.message))}, (r) {
        SavedLoaded votedLoaded = SavedLoaded(
          auth.getOrgaId()!,
          auth.getUserId()!,
          flowId,
          stageId,
          event.positive,
          event.searchText,
          event.fieldsOrder,
          event.pageIndex,
          event.pageSize,
          r.items,
          r.currentItemCount,
          r.totalItems ?? 0,
          r.totalPages ?? 1,
          validLogin,
        );

        emit(votedLoaded);
      });
    });

    on<OnSavedAddVote>((event, emit) async {
      String flowId = Flows.votationFlowId;
      String stageId = StagesVotationFlow.stageId03Voting;
      var auth = const SessionModel(token: "", username: "", name: "");
      final session = await _getSession.execute();
      session.fold((l) => emit(SavedError(l.message)), (r) => {auth = r});

      final result = await _votePublication.execute(auth.getOrgaId()!,
          auth.getUserId()!, flowId, stageId, event.postId, event.voteValue);
      result.fold((l) => emit(SavedError(l.message)), (r) {});
    });
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
