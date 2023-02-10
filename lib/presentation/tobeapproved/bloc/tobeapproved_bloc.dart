import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/presentation/tobeapproved/bloc/tobeapproved_event.dart';
import 'package:lomba_frontend/presentation/tobeapproved/bloc/tobeapproved_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/models/session_model.dart';
import '../../../domain/usecases/flow/get_for_approve_posts.dart';
import '../../../domain/usecases/local/get_session_status.dart';

class ToBeApprovedBloc extends Bloc<ToBeApprovedEvent, ToBeApprovedState>{
  final GetForApprovePosts _getForApprovePosts;
  final GetSession _getSession;

  ToBeApprovedBloc(
    this._getForApprovePosts,
    this._getSession
  ):super(ToBeApprovedStart()){
    on<OnToBeApprovedLoad>((event, emit)async{
      emit(ToBeApprovedLoading());
      String flowId = '00000111-0111-0111-0111-000000000111';
      String stageId = '00000AAA-0111-0111-0111-000000000111';

      var auth = const SessionModel(token: "", username: "", name: "");
      final session = await _getSession.execute();
      session.fold((l) => emit(ToBeApprovedError(l.message)), (r) => {auth = r});

      final result = await _getForApprovePosts.execute(
          auth.getOrgaId()!,
          auth.getUserId()!,
          flowId,
          stageId,       
          event.searchText,
          event.fieldsOrder,
          event.pageIndex,
          event.pageSize);
      
      result.fold(
          (l) => {emit(ToBeApprovedError(l.message))},
          (r) => emit(ToBeApprovedLoaded(
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
              r.items.length
              )));
    });
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}