import 'package:equatable/equatable.dart';

///Mensajes de falla en el sistema.
///
///Se utiliza para enviar mensajes de error hacia el page.

///Clase abstracta (interfaz en Dart) para los mensajes de falla.
abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

///Falla del servidor (backend)
class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

///Falla de conexión (network)
class ConnectionFailure extends Failure {
  const ConnectionFailure(String message) : super(message);
}

///Falla de base de datos.
class DatabaseFailure extends Failure {
  const DatabaseFailure(String message) : super(message);
}

///Falla en el caché del dispositivo (localStorage).
class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}
