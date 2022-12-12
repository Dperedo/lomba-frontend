import 'package:lomba_frontend/features/login/domain/entities/login_access.dart';

class LoginAccessModel extends LoginAccess {
  const LoginAccessModel(
      {required String token, required String username, required String name})
      : super(token: token, username: username, name: name);

  factory LoginAccessModel.fromJson(Map<String, dynamic> json) {
    return LoginAccessModel(
        token: json["token"], username: json["username"], name: json["name"]);
  }

  Map<String, dynamic> toJson() {
    return {'token': token, 'username': username, 'name': name};
  }

  LoginAccess toEntity() =>
      LoginAccess(token: token, username: username, name: name);

  @override
  List<Object> get props => [token, username, name];
}
