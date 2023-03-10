import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/presentation/tobeapproved/bloc/tobeapproved_event.dart';
import 'package:lomba_frontend/presentation/tobeapproved/bloc/tobeapproved_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/constants.dart';
import '../../../data/models/session_model.dart';
import '../../../domain/usecases/post/get_for_approve_posts.dart';
import '../../../domain/usecases/post/vote_publication.dart';
import '../../../domain/usecases/local/get_session_status.dart';

class ToBeApprovedBloc extends Bloc<ToBeApprovedEvent, ToBeApprovedState> {
  final GetForApprovePosts _getForApprovePosts;
  final GetSession _getSession;
  final VotePublication _votePublication;

  ToBeApprovedBloc(
      this._getForApprovePosts, this._getSession, this._votePublication)
      : super(ToBeApprovedStart()) {
    on<OnToBeApprovedStarter>((event, emit) => emit(ToBeApprovedStart()));

    on<OnToBeApprovedLoad>((event, emit) async {
      emit(ToBeApprovedLoading());
      String flowId = Flows.votationFlowId;
      String stageId = StagesVotationFlow.stageId02Approval;

      var auth = const SessionModel(token: "", username: "", name: "");
      final session = await _getSession.execute();
      session.fold(
          (l) => emit(ToBeApprovedError(l.message)), (r) => {auth = r});

      final result = await _getForApprovePosts.execute(
          auth.getOrgaId()!,
          auth.getUserId()!,
          flowId,
          stageId,
          event.searchText,
          event.fieldsOrder,
          event.pageIndex,
          event.pageSize);

      result.fold((l) => {emit(ToBeApprovedError(l.message))}, (r) {
        int totalPages = (r.items.length / event.pageSize).round();
        if (totalPages == 0) totalPages = 1;

        emit(ToBeApprovedLoaded(
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
            totalPages));
      });
    });

    on<OnToBeApprovedVote>((event, emit) async {
      String flowId = Flows.votationFlowId;
      String stageId = StagesVotationFlow.stageId02Approval;
      var auth = const SessionModel(token: "", username: "", name: "");
      final session = await _getSession.execute();
      session.fold(
          (l) => emit(ToBeApprovedError(l.message)), (r) => {auth = r});

      final result = await _votePublication.execute(auth.getOrgaId()!,
          auth.getUserId()!, flowId, stageId, event.postId, event.voteValue);
      result.fold((l) => emit(ToBeApprovedError(l.message)), (r) {});
    });
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
