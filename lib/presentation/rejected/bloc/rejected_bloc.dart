import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/post/vote_publication.dart';
import 'package:lomba_frontend/presentation/rejected/bloc/rejected_event.dart';
import 'package:lomba_frontend/presentation/rejected/bloc/rejected_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/constants.dart';
import '../../../data/models/session_model.dart';
import '../../../domain/usecases/post/get_rejected_posts.dart';
import '../../../domain/usecases/local/get_session_status.dart';

class RejectedBloc extends Bloc<RejectedEvent, RejectedState> {
  final GetRejectedPosts _getRejectedPosts;
  final GetSession _getSession;
  final VotePublication _votePublication;

  RejectedBloc(this._getRejectedPosts, this._getSession, this._votePublication)
      : super(RejectedStart()) {
    on<OnRejectedStarter>((event, emit) => emit(RejectedStart()));

    on<OnRejectedLoad>((event, emit) async {
      emit(RejectedLoading());
      String flowId = Flows.votationFlowId;
      String stageId = StagesVotationFlow.stageId02Approval;

      var auth = const SessionModel(token: "", username: "", name: "");
      final session = await _getSession.execute();
      session.fold((l) => emit(RejectedError(l.message)), (r) => {auth = r});

      final result = await _getRejectedPosts.execute(
        auth.getOrgaId()!,
        auth.getUserId()!,
        flowId,
        stageId,
        event.searchText,
        event.fieldsOrder,
        event.pageIndex,
        event.pageSize,
      );

      result.fold((l) => {emit(RejectedError(l.message))}, (r) {
        int totalPages = (r.items.length / event.pageSize).round();
        if (totalPages == 0) totalPages = 1;

        emit(RejectedLoaded(
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
          totalPages,
        ));
      });
    });

    on<OnRejectedVote>((event, emit) async {
      String flowId = Flows.votationFlowId;
      String stageId = StagesVotationFlow.stageId02Approval;
      var auth = const SessionModel(token: "", username: "", name: "");
      final session = await _getSession.execute();
      session.fold((l) => emit(RejectedError(l.message)), (r) => {auth = r});

      final result = await _votePublication.execute(auth.getOrgaId()!,
          auth.getUserId()!, flowId, stageId, event.postId, event.voteValue);
      result.fold((l) => emit(RejectedError(l.message)), (r) {});
    });
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
