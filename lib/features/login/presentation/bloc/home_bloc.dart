import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/features/login/domain/usecases/validate_login.dart';
import 'package:rxdart/rxdart.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ValidateLogin _validateLogin;

  HomeBloc(this._validateLogin) : super(HomeStart()) {
    on<OnHomeLoading>(
      (event, emit) async {
        final result = await _validateLogin.execute();

        result.fold((failure) => {}, (valid) => {emit(HomeLoaded(valid))});
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
