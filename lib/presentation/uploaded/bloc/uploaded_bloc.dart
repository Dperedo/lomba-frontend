import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/domain/usecases/flow/get_uploaded_posts.dart';
import 'package:lomba_frontend/domain/usecases/flow/vote_publication.dart';
import 'package:lomba_frontend/domain/usecases/local/get_session_status.dart';
import 'package:lomba_frontend/presentation/uploaded/bloc/uploaded_event.dart';
import 'package:lomba_frontend/presentation/uploaded/bloc/upoaded_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/models/session_model.dart';

class UploadedBloc extends Bloc<UploadedEvent, UploadedState> {
  final GetUploadedPosts _getUploadedPosts;
  final GetSession _getSession;
  final VotePublication _votePublication;

  UploadedBloc(this._getUploadedPosts, this._getSession, this._votePublication)
      : super(UploadedStart()) {
    on<OnUploadedLoad>((event, emit) async {
      emit(UploadedLoading());
      String flowId = Flows.votationFlowId;
      String stageId = StagesVotationFlow.stageId01Load;

      var auth = const SessionModel(token: "", username: "", name: "");
      final session = await _getSession.execute();
      session.fold((l) => emit(UploadedError(l.message)), (r) => {auth = r});

      final result = await _getUploadedPosts.execute(
          auth.getOrgaId()!,
          auth.getUserId()!,
          flowId,
          stageId,
          event.onlydrafts,
          event.searchText,
          event.fieldsOrder,
          event.pageIndex,
          event.pageSize);

      result.fold((l) => {emit(UploadedError(l.message))}, (r) {
        final voteEntries = r.items.map((e) => e.votes.isNotEmpty
            ? <String, int>{e.id: e.votes.first.value}
            : <String, int>{});

        emit(UploadedLoaded(
            auth.getOrgaId()!,
            auth.getUserId()!,
            flowId,
            stageId,
            event.onlydrafts,
            event.searchText,
            event.fieldsOrder,
            event.pageIndex,
            event.pageSize,
            r.items,
            r.currentItemCount,
            r.items.length,
            r.items.length));
      });
    });

    on<OnUploadedVote>((event, emit) async {
      String flowId = Flows.votationFlowId;
      String stageId = StagesVotationFlow.stageId01Load;
      var auth = const SessionModel(token: "", username: "", name: "");
      final session = await _getSession.execute();
      session.fold((l) => emit(UploadedError(l.message)), (r) => {auth = r});

      final result = await _votePublication.execute(auth.getOrgaId()!,
          auth.getUserId()!, flowId, stageId, event.postId, event.voteValue);
      result.fold((l) => emit(UploadedError(l.message)), (r) {emit(UploadedStart());});
    });
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
