import 'package:equatable/equatable.dart';

///Entidad de Session utilizada internamente.
///
///[Session] es más sencilla que el [SessionModel] que la implementa.
///[token] contiene el token recibido en el inicio de sesión autenticado.
///[username] es el nombre de usuario (para el sistema).
///[name] es el nombre de pila del usuaro. Ejemplo: Miguel Peredo.
class Session extends Equatable {
  const Session(
      {required this.token, required this.username, required this.name});

  final String token;
  final String username;
  final String name;
  @override
  List<Object> get props => [token, username, name];
}
