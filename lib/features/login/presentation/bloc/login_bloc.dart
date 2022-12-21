import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/features/login/domain/usecases/get_authenticate.dart';
import 'package:rxdart/rxdart.dart';
import 'login_event.dart';
import 'login_state.dart';

///BLOC que controla la funcionalidad de Login de usuario.
///
///Considera dos eventos, el que intenta hacer el login y otro para
///reiniciar la pantalla.
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GetAuthenticate _getAuthenticate;

  LoginBloc(this._getAuthenticate) : super(LoginEmpty()) {
    on<OnLoginTriest>(
      (event, emit) async {
        final username = event.username;
        final password = event.password;

        ///El siguiente emit envía la instrucción de mostrar el spinner
        emit(LoginGetting());

        final result = await _getAuthenticate.execute(username, password);
        result.fold((failure) => {emit(LoginError(failure.message))},
            (token) => {emit(LoginGoted(token))});
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    ///Evento que sólo busca reiniciar la pantalla de login
    on<OnRestartLogin>((event, emit) async {
      emit(LoginEmpty());
    });
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
