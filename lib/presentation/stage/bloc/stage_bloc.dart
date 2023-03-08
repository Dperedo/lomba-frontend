import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/presentation/stage/bloc/stage_event.dart';
import 'package:lomba_frontend/presentation/stage/bloc/stage_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/usecases/stage/get_stage.dart';
import '../../../domain/usecases/stage/get_stages.dart';

class StageBloc extends Bloc<StageEvent, StageState> {
  //final EnableStage _enableStage;
  final GetStage _getStage;
  final GetStages _getStages;

  StageBloc(
    //this._enableStage,
    this._getStage,
    this._getStages,
  ) : super(StageStart()) {
    on<OnStageLoad>(
      (event, emit) async {
        emit(StageLoading());

        final result = await _getStage.execute(event.name);

        result.fold((l) => emit(StageError(l.message)),
            (role) => {emit(StageLoaded(role))});
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    on<OnStageListLoad>(
      (event, emit) async {
        emit(StageLoading());
        final result = await _getStages.execute();

        result.fold((l) => emit(StageError(l.message)),
            (listStages) => {emit(StageListLoaded(listStages))});
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    /*on<OnStageEnable>((event, emit) async {
      emit(StageLoading());

      final result = await _enableStage.execute(event.name, event.enabled);
      result.fold(
          (l) => emit(StageError(l.message)), (r) => {emit(StageLoaded(r))});
    });*/
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
