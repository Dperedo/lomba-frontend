import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/features/sidedrawer/domain/usecases/do_logoff.dart';
import 'package:lomba_frontend/features/sidedrawer/domain/usecases/get_side_options.dart';
import 'package:lomba_frontend/features/sidedrawer/presentation/bloc/sidedrawer_event.dart';
import 'package:lomba_frontend/features/sidedrawer/presentation/bloc/sidedrawer_state.dart';
import 'package:rxdart/rxdart.dart';

class SideDrawerBloc extends Bloc<SideDrawerEvent, SideDrawerState> {
  final GetSideOptions _getOptions;
  final DoLogOff _doLogOff;

  SideDrawerBloc(this._getOptions, this._doLogOff) : super(SideDrawerEmpty()) {
    on<OnSideDrawerLoading>(
      (event, emit) async {
        emit(SideDrawerLoading());

        final result = await _getOptions.execute();

        result.fold(
            (failure) => {}, (optList) => {emit(SideDrawerReady(optList))});
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    on<OnSideDrawerLogOff>((event, emit) async {
      final result = await _doLogOff.execute();

      result.fold((l) => {}, (r) => {emit(SideDrawerEmpty())});
    });
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
