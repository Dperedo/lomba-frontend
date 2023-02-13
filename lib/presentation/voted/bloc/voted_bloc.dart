import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/entities/flows/post.dart';
import 'package:lomba_frontend/domain/usecases/flow/get_uploaded_posts.dart';
import 'package:lomba_frontend/domain/usecases/flow/vote_publication.dart';
import 'package:lomba_frontend/presentation/voted/bloc/voted_event.dart';
import 'package:lomba_frontend/presentation/voted/bloc/voted_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/constants.dart';
import '../../../data/models/session_model.dart';
import '../../../domain/usecases/flow/get_voted_posts.dart';
import '../../../domain/usecases/local/get_session_status.dart';

class VotedBloc extends Bloc<VotedEvent, VotedState> {
  final GetVotedPosts _getVotedPosts;
  final GetSession _getSession;
  final VotePublication _votePublication;
  final GetUploadedPosts _getUploadedPosts;

  VotedBloc(this._getVotedPosts, this._getSession, this._votePublication,
      this._getUploadedPosts)
      : super(VotedStart()) {
    on<OnVotedLoad>((event, emit) async {
      emit(VotedLoading());
      String flowId = Flows.votationFlowId;
      String stageId = StagesVotationFlow.stageId03Voting;

      var auth = const SessionModel(token: "", username: "", name: "");
      final session = await _getSession.execute();
      session.fold((l) => emit(VotedError(l.message)), (r) => {auth = r});
      int voteValue = 0;
      if(event.positive)
      {
       voteValue = 1;
      } else if(event.negative)
      {
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
      result.fold((l) => {emit(VotedError(l.message))}, (r) {
        VotedLoaded votedLoaded = VotedLoaded(
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
          r.items.length,
          r.items.length,
        );

        emit(votedLoaded);
      });
    });

    on<OnVotedAddVote>((event, emit) async {
      String flowId = Flows.votationFlowId;
      String stageId = StagesVotationFlow.stageId03Voting;
      var auth = const SessionModel(token: "", username: "", name: "");
      final session = await _getSession.execute();
      session.fold((l) => emit(VotedError(l.message)), (r) => {auth = r});

      final result = await _votePublication.execute(auth.getOrgaId()!,
          auth.getUserId()!, flowId, stageId, event.postId, event.voteValue);
      result.fold((l) => emit(VotedError(l.message)), (r) {});
    });
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
