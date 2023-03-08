import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/flow/get_flow.dart';
import 'package:lomba_frontend/domain/usecases/flow/get_flows.dart';
import 'package:lomba_frontend/domain/usecases/roles/enable_role.dart';
import 'package:lomba_frontend/domain/usecases/roles/get_role.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/usecases/roles/get_roles.dart';
import 'flow_event.dart';
import 'flow_state.dart';

class FlowBloc extends Bloc<FlowEvent, FlowState> {
  //final EnableFlow _enableFlow;
  final GetFlow _getFlow;
  final GetFlows _getFlows;

  FlowBloc(
    //this._enableFlow,
    this._getFlow,
    this._getFlows,
  ) : super(FlowStart()) {
    on<OnFlowLoad>(
      (event, emit) async {
        emit(FlowLoading());

        final result = await _getFlow.execute(event.name);

        result.fold((l) => emit(FlowError(l.message)),
            (role) => {emit(FlowLoaded(role))});
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    on<OnFlowListLoad>(
      (event, emit) async {
        emit(FlowLoading());
        final result = await _getFlows.execute();

        result.fold((l) => emit(FlowError(l.message)),
            (listFlows) => {emit(FlowListLoaded(listFlows))});
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    /*on<OnFlowEnable>((event, emit) async {
      emit(FlowLoading());

      final result = await _enableFlow.execute(event.name, event.enabled);
      result.fold(
          (l) => emit(FlowError(l.message)), (r) => {emit(FlowLoaded(r))});
    });*/
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
