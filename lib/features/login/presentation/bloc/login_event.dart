import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class OnLoginTriest extends LoginEvent {
  final String username;
  final String password;

  const OnLoginTriest(this.username, this.password);

  @override
  List<Object?> get props => [username, password];
}

class OnRestartLogin extends LoginEvent {}
