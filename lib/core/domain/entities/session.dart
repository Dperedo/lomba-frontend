import 'package:equatable/equatable.dart';

class Session extends Equatable {
  const Session(
      {required this.token, required this.username, required this.name});

  final String token;
  final String username;
  final String name;

  @override
  List<Object> get props => [token, username, name];
}
