import '../../domain/entities/session.dart';

class SessionModel extends Session {
  const SessionModel(
      {required String token, required String username, required String name})
      : super(token: token, username: username, name: name);

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
        token: json["token"], username: json["username"], name: json["name"]);
  }

  Map<String, dynamic> toJson() {
    return {'token': token, 'username': username, 'name': name};
  }

  Session toEntity() => Session(token: token, username: username, name: name);

  @override
  List<Object> get props => [token, username, name];
}
