import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/flow/get_approved_posts.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/models/session_model.dart';

import '../../../domain/usecases/local/get_session_status.dart';
import 'approved_event.dart';
import 'approved_state.dart';

class ApprovedBloc extends Bloc<ApprovedEvent, ApprovedState> {
  final GetApprovedPosts _getApprovedPosts;
  /*final GetForApprovePosts _getForApprovePosts;
  final GetUploadedPosts _getUploadedPosts;
  final GetVotedPosts _getVotedPosts;
  final VotePublication _votePublication;*/
  final GetSession _getSession;

  ApprovedBloc(
      this._getApprovedPosts,
      /*this._getForApprovePosts,
    this._getUploadedPosts,
    this._getVotedPosts,
    this._votePublication,*/
      this._getSession)
      : super(ApprovedStart()) {
    on<OnApprovedLoad>((event, emit) async {
      emit(ApprovedLoading());
      String flowId = '00000111-0111-0111-0111-000000000111';
      String stageId = '00000BBB-0111-0111-0111-000000000111';

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

      result.fold(
          (l) => {emit(ApprovedError(l.message))},
          (r) => emit(ApprovedLoaded(
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
              )));
    });
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
