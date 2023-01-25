import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lomba_frontend/features/login/domain/usecases/get_authenticate.dart';
import 'package:lomba_frontend/features/login/domain/usecases/get_authenticate_google.dart';
import 'package:lomba_frontend/features/users/domain/entities/user.dart'
    as entities;
import 'package:rxdart/rxdart.dart';

import 'login_event.dart';
import 'login_state.dart';

///BLOC que controla la funcionalidad de Login de usuario.
///
///Considera dos eventos, el que intenta hacer el login y otro para
///reiniciar la pantalla.
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GetAuthenticate _getAuthenticate;
  final GetAuthenticateGoogle _getAuthenticateGoogle;

  LoginBloc(this._getAuthenticate, this._getAuthenticateGoogle)
      : super(LoginEmpty()) {
    on<OnLoginTriest>(
      (event, emit) async {
        final username = event.username;
        final password = event.password;

        ///El siguiente emit envía la instrucción de mostrar el spinner
        emit(LoginGetting());

        final result = await _getAuthenticate.execute(username, password);
        result.fold((failure) => {emit(LoginError(failure.message))},
            (session) => {emit(LoginGoted(session))});
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    ///Evento que sólo busca reiniciar la pantalla de login
    on<OnRestartLogin>((event, emit) async {
      emit(LoginEmpty());
    });

    on<OnLoginWithGoogle>(
      (event, emit) async {
        UserCredential? credentials;

        if (kIsWeb) {
          try {
            credentials = await signInWithGoogle();
          } catch (e) {}
        } else {
          if (Platform.isAndroid || Platform.isIOS) {
            try {
              credentials = await signInWithGoogleMobile();
            } catch (e) {}
          }
        }

        if (credentials != null) {
          entities.User user = entities.User(
              id: "",
              name: credentials.user!.displayName ?? "",
              username: credentials.user!.email ?? "",
              email: credentials.user!.email ?? "",
              enabled: true,
              builtIn: false);

          String userToken = await credentials.user!.getIdToken();

          final result = await _getAuthenticateGoogle.execute(user, userToken);
          result.fold((failure) => {emit(LoginError(failure.message))},
              (token) => {emit(LoginGoted(token))});
        }
      },
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Create a new provider
  GoogleAuthProvider googleProvider = GoogleAuthProvider();

  //googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
  googleProvider.addScope('email');
  googleProvider.setCustomParameters({'prompt': 'select_account'});

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithPopup(googleProvider);

  // Or use signInWithRedirect
  // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
}

Future<UserCredential> signInWithGoogleMobile() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
