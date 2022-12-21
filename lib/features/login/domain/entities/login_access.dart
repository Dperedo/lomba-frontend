import 'package:equatable/equatable.dart';

///Entidad LoginAccess para la recepción de información desde el backend
///de autenticación del usuario.
///
///[token] contiene el token entregado por el backend
///[username] nombre de usuario (para el sistema)
///[name] nombre de pila del usuario. Ejemplo: Miguel Peredo.
class LoginAccess extends Equatable {
  const LoginAccess(
      {required this.token, required this.username, required this.name});

  final String token;
  final String username;
  final String name;

  @override
  List<Object> get props => [token, username, name];
}
