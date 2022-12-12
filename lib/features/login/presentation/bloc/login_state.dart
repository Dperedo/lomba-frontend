import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginEmpty extends LoginState {}

class LoginJumping extends LoginState {}

class LoginGetting extends LoginState {}

class LoginError extends LoginState {
  final String message;

  const LoginError(this.message);

  @override
  List<Object> get props => [message];
}

class LoginGoted extends LoginState {
  final bool result;

  const LoginGoted(this.result);

  @override
  List<Object> get props => [result];
}
