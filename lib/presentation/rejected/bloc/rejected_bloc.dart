import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/presentation/rejected/bloc/rejected_event.dart';
import 'package:lomba_frontend/presentation/rejected/bloc/rejected_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/models/session_model.dart';
import '../../../domain/usecases/flow/get_rejected_posts.dart';
import '../../../domain/usecases/local/get_session_status.dart';

class RejectedBloc extends Bloc<RejectedEvent, RejectedState>{
  final GetRejectedPosts _getRejectedPosts;
  final GetSession _getSession;

  RejectedBloc(
    this._getRejectedPosts,
    this._getSession
  ):super(RejectedStart()){
    on<OnRejectedLoad>((event, emit)async{
      emit(RejectedLoading());
      String flowId = '00000111-0111-0111-0111-000000000111';
      String stageId = '00000BBB-0111-0111-0111-000000000111';
      

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

      result.fold(
          (l) => {emit(RejectedError(l.message))},
          (r) => emit(RejectedLoaded(
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
              r.items.length ,
              r.items.length,
              )));


    }
    );
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}