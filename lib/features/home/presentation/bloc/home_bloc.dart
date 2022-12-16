import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/domain/usecases/get_has_login.dart';
import 'package:rxdart/rxdart.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHasLogIn _hasLogin;

  HomeBloc(this._hasLogin) : super(HomeStart()) {
    on<OnHomeLoading>(
      (event, emit) async {
        emit(HomeLoading());

        final result = await _hasLogin.execute();

        result.fold((failure) => {}, (valid) => {emit(HomeLoaded(valid))});
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    on<OnRestartHome>((event, emit) async {
      emit(HomeStart());
    });
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
