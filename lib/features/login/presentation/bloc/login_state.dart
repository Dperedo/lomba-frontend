import 'package:equatable/equatable.dart';

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

///Estado cuando ya está logueado. Considera la respuesta que permitirá saltar
///a otra pantalla.
class LoginGoted extends LoginState {
  final bool result;

  const LoginGoted(this.result);

  @override
  List<Object> get props => [result];
}
