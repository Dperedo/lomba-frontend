import 'package:equatable/equatable.dart';

///Interfaz de los eventos de Login con herencia de Equatable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

///Evento que intenta hacer login con username y password
class OnLoginTriest extends LoginEvent {
  final String username;
  final String password;

  const OnLoginTriest(this.username, this.password);

  @override
  List<Object?> get props => [username, password];
}

class OnLoginChangeOrga extends LoginEvent {
  final String username;
  final String orgaId;

  const OnLoginChangeOrga(this.username, this.orgaId);

  @override
  List<Object?> get props => [username, orgaId];
}

class OnLoginWithGoogle extends LoginEvent {}

///Evento para el reinicio de la pantalla
class OnLoginStarter extends LoginEvent {}
