import 'package:equatable/equatable.dart';
import 'package:lomba_frontend/features/login/domain/entities/token.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginEmpty extends LoginState {}

class LoginGetting extends LoginState {}

class LoginError extends LoginState {
  final String message;

  LoginError(this.message);

  @override
  List<Object> get props => [message];
}

class LoginGot extends LoginState {
  final Token result;

  LoginGot(this.result);

  @override
  List<Object> get props => [result];
}
