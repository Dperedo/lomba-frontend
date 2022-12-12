import 'package:equatable/equatable.dart';

class LoginAccess extends Equatable {
  const LoginAccess(
      {required this.token, required this.username, required this.name});

  final String token;
  final String username;
  final String name;

  @override
  List<Object> get props => [token, username, name];
}
