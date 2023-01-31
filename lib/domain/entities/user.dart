import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.enabled,
      required this.builtIn});

  final String id;
  final String name;
  final String username;
  final String email;
  final bool enabled;
  final bool builtIn;

  @override
  List<Object> get props => [id, name, username, email, enabled, builtIn];
}
