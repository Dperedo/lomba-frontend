import 'package:equatable/equatable.dart';

///Entidad LoginAccess para la recepción de información desde el backend
///de autenticación del usuario.
class LoginAccess extends Equatable {
  const LoginAccess(
      {required this.token, required this.username, required this.name});

  final String token;
  final String username;
  final String name;

  @override
  List<Object> get props => [token, username, name];
}
