import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/domain/usecases/get_has_login.dart';
import 'package:rxdart/rxdart.dart';
import 'home_event.dart';
import 'home_state.dart';

///BLOC para el control de la página principal o Home
///
///Consulta si el usuario está logueado o no.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHasLogIn _hasLogin;

  HomeBloc(this._hasLogin) : super(HomeStart()) {
    ///Evento que hace la consulta de sesión del usuario en el dispositivo.
    on<OnHomeLoading>(
      (event, emit) async {
        emit(HomeLoading());

        final result = await _hasLogin.execute();

        result.fold((failure) => {}, (valid) => {emit(HomeLoaded(valid))});
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    ///Evento es llamado para reiniciar el Home y haga la consulta de sesión.
    on<OnRestartHome>((event, emit) async {
      emit(HomeStart());
    });
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
