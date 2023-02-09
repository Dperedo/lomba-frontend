import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/local/get_has_login.dart';
import 'package:rxdart/rxdart.dart';
import 'home_event.dart';
import 'home_state.dart';

///BLOC para el control de la página principal o Home
///
///Consulta si el usuario está logueado o no.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHasLogIn _hasLogin;
  final FirebaseAuth _firebaseAuthInstance;

  HomeBloc(this._firebaseAuthInstance, this._hasLogin) : super(HomeStart()) {
    ///Evento que hace la consulta de sesión del usuario en el dispositivo.
    on<OnHomeLoading>(
      (event, emit) async {
        emit(HomeLoading());

        final result = await _hasLogin.execute();

        result.fold((failure) => {}, (valid) async {
          //emit(HomeLoaded(valid));

          if (!valid) {
            try {
              await signInAnonymously();
            } catch (e) {}
          }
        });
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

  Future<UserCredential> signInAnonymously() async {
    return await _firebaseAuthInstance.signInAnonymously();
  }
}
