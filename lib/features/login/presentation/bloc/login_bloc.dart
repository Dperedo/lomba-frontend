import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/domain/usecases/get_has_login.dart';
import 'package:lomba_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:lomba_frontend/features/login/domain/usecases/get_authenticate.dart';
import 'package:rxdart/rxdart.dart';
import '../../../home/presentation/bloc/home_event.dart';
import '../../../home/presentation/bloc/home_state.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GetAuthenticate _getAuthenticate;

  LoginBloc(this._getAuthenticate) : super(LoginEmpty()) {
    on<OnLoginTriest>(
      (event, emit) async {
        final username = event.username;
        final password = event.password;

        emit(LoginGetting());

        final result = await _getAuthenticate.execute(username, password);
        result.fold((failure) => {emit(LoginError(failure.message))},
            (token) => {emit(LoginGoted(token))});
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    on<OnRestartLogin>((event, emit) async {
      emit(LoginJumping());
      emit(LoginEmpty());
    });
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
