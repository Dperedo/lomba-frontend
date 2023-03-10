import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/post/get_approved_posts.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/constants.dart';
import '../../../data/models/session_model.dart';

import '../../../domain/usecases/post/vote_publication.dart';
import '../../../domain/usecases/local/get_session_status.dart';
import 'approved_event.dart';
import 'approved_state.dart';

class ApprovedBloc extends Bloc<ApprovedEvent, ApprovedState> {
  final GetApprovedPosts _getApprovedPosts;
  final VotePublication _votePublication;
  final GetSession _getSession;

  ApprovedBloc(this._getApprovedPosts, this._votePublication, this._getSession)
      : super(ApprovedStart()) {
    on<OnApprovedStarter>((event, emit) => emit(ApprovedStart()));

    on<OnApprovedLoad>((event, emit) async {
      emit(ApprovedLoading());
      String flowId = Flows.votationFlowId;
      String stageId = StagesVotationFlow.stageId02Approval;

      var auth = const SessionModel(token: "", username: "", name: "");
      final session = await _getSession.execute();
      session.fold((l) => emit(ApprovedError(l.message)), (r) => {auth = r});

      final result = await _getApprovedPosts.execute(
        auth.getOrgaId()!,
        auth.getUserId()!,
        flowId,
        stageId,
        event.searchText,
        event.fieldsOrder,
        event.pageIndex,
        event.pageSize,
      );

      result.fold((l) => {emit(ApprovedError(l.message))}, (r) {
        int totalPages = (r.items.length / event.pageSize).round();
        if (totalPages == 0) totalPages = 1;

        emit(ApprovedLoaded(
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

    on<OnApprovedVote>((event, emit) async {
      String flowId = Flows.votationFlowId;
      String stageId = StagesVotationFlow.stageId02Approval;
      var auth = const SessionModel(token: "", username: "", name: "");
      final session = await _getSession.execute();
      session.fold((l) => emit(ApprovedError(l.message)), (r) => {auth = r});

      final result = await _votePublication.execute(auth.getOrgaId()!,
          auth.getUserId()!, flowId, stageId, event.postId, event.voteValue);
      result.fold((l) => emit(ApprovedError(l.message)), (r) {});
    });
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
