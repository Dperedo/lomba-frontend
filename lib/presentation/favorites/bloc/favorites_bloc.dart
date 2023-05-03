import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/post/get_uploaded_posts.dart';
import 'package:lomba_frontend/domain/usecases/post/vote_publication.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/constants.dart';
import '../../../data/models/session_model.dart';
import '../../../domain/usecases/local/get_session_status.dart';
import '../../../domain/usecases/post/get_voted_posts.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetVotedPosts _getVotedPosts;
  final GetSession _getSession;
  final VotePublication _votePublication;
  final GetUploadedPosts _getUploadedPosts;

  FavoritesBloc(this._getVotedPosts, this._getSession, this._votePublication,
      this._getUploadedPosts)
      : super(FavoritesStart()) {
    on<OnFavoritesStarter>((event, emit) => emit(FavoritesStart()));

    on<OnFavoritesLoad>((event, emit) async {
      emit(FavoritesLoading());
      String flowId = Flows.votationFlowId;
      String stageId = StagesVotationFlow.stageId03Voting;

      var auth = const SessionModel(token: "", username: "", name: "");
      final session = await _getSession.execute();
      session.fold((l) => emit(FavoritesError(l.message)), (r) => {auth = r});
      int voteValue = 0;
      if (event.positive) {
        voteValue = 1;
      } else if (event.negative) {
        voteValue = -1;
      }
      final result = await _getVotedPosts.execute(
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
      result.fold((l) => {emit(FavoritesError(l.message))}, (r) {
        FavoritesLoaded votedLoaded = FavoritesLoaded(
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
        );

        emit(votedLoaded);
      });
    });

    on<OnFavoritesAddVote>((event, emit) async {
      String flowId = Flows.votationFlowId;
      String stageId = StagesVotationFlow.stageId03Voting;
      var auth = const SessionModel(token: "", username: "", name: "");
      final session = await _getSession.execute();
      session.fold((l) => emit(FavoritesError(l.message)), (r) => {auth = r});

      final result = await _votePublication.execute(auth.getOrgaId()!,
          auth.getUserId()!, flowId, stageId, event.postId, event.voteValue);
      result.fold((l) => emit(FavoritesError(l.message)), (r) {});
    });
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
