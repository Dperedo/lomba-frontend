import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/entities/flows/post.dart';
import 'package:lomba_frontend/domain/usecases/flow/get_uploaded_posts.dart';
import 'package:lomba_frontend/domain/usecases/flow/vote_publication.dart';
import 'package:lomba_frontend/presentation/voted/bloc/voted_event.dart';
import 'package:lomba_frontend/presentation/voted/bloc/voted_state.dart';
import 'package:rxdart/rxdart.dart';

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
      String flowId = '00000111-0111-0111-0111-000000000111';
      String stageId = '00000AAA-0111-0111-0111-000000000111';

      var auth = const SessionModel(token: "", username: "", name: "");
      final session = await _getSession.execute();
      session.fold((l) => emit(VotedError(l.message)), (r) => {auth = r});

      final result = await _getUploadedPosts.execute(
        auth.getOrgaId()!,
        auth.getUserId()!,
        flowId,
        stageId,
        false,
        event.searchText,
        event.fieldsOrder,
        event.pageIndex,
        event.pageSize,
      );
      result.fold((l) => {emit(VotedError(l.message))}, (r) {
        VotedLoaded votedLoaded = VotedLoaded(
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
        );

        for (int i = 0; i < r.items.length; i++) {
          votedLoaded.votes.addEntries(<String, int>{
            r.items[i].id: r.items[i].votes.first.value
          }.entries);
        }

        emit(votedLoaded);
      });
    });

    on<OnVotedAddVote>((event, emit) async {
      String flowId = '00000111-0111-0111-0111-000000000111';
      String stageId = '00000BBB-0111-0111-0111-000000000111';
      var auth = const SessionModel(token: "", username: "", name: "");
      final session = await _getSession.execute();
      session.fold((l) => emit(VotedError(l.message)), (r) => {auth = r});

      final result = await _votePublication.execute(auth.getOrgaId()!,
          auth.getUserId()!, flowId, stageId, event.postId, event.voteValue);
      result.fold((l) => emit(VotedError(l.message)), (r) {
        event.voteLoaded.votes
            .addEntries(<String, int>{event.postId: event.voteValue}.entries);

        emit(event.voteLoaded);
      });
    });
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
