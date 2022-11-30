import '../../domain/entities/login.dart';

class LoginModel extends Login {
  const LoginModel({required String username, required String password})
      : super(username: username, password: password);
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(username: json["username"], password: json["password"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }

  Login toEntity() => Login(username: username, password: password);

  @override
  List<Object> get props => [username, password];
}
