import 'package:equatable/equatable.dart';

import '../../../data/models/session_model.dart';
import '../../../domain/entities/orga.dart';

///Interfaz de estados para Login
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

///Estado de login vacío, es el inicial (Start)
class LoginEmpty extends LoginState {}

///Estado que muestra el spinner en pantalla mientras intenta loguear.
class LoginGetting extends LoginState {}

///Estado en caso de error, considera un mensaje para el usuario.
class LoginError extends LoginState {
  final String message;

  const LoginError(this.message);

  @override
  List<Object> get props => [message];
}

class LoginSelectOrga extends LoginState {
  final String username;
  final List<Orga> orgas;
  const LoginSelectOrga(this.orgas, this.username);
  @override
  List<Object> get props => [orgas, username];
}

///Estado cuando ya está logueado. Considera la respuesta que permitirá saltar
///a otra pantalla.
class LoginGoted extends LoginState {
  final SessionModel? result;
  final String message;

  const LoginGoted(this.result, this.message);

  @override
  List<Object> get props => [];
}
