import 'package:equatable/equatable.dart';

///Entidad de Session utilizada internamente.
///
///[Session] es más sencilla que el [SessionModel] que la implementa.

class Session extends Equatable {
  const Session(
      {required this.token, required this.username, required this.name});

  final String token;
  final String username;
  final String name;

  @override
  List<Object> get props => [token, username, name];
}
