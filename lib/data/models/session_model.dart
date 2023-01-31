import 'package:jwt_decode/jwt_decode.dart';

import '../../domain/entities/session.dart';
import '../../core/validators.dart';

///Modelo de la Sesión de usuario.
///
///Esta clase se lleva consigo información de sesión para la app

class SessionModel extends Session {
  const SessionModel(
      {required String token, required String username, required String name})
      : super(token: token, username: username, name: name);

  ///Entrega un nuevo [SessionModel] desde un Map (json)
  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
        token: json["token"], username: json["username"], name: json["name"]);
  }

  ///Entrega el objeto actual a un Map (json)
  Map<String, dynamic> toJson() {
    return {'token': token, 'username': username, 'name': name};
  }

  ///Entrega una [Session] a partir del actual [SessionModel]
  Session toEntity() => Session(token: token, username: username, name: name);

  ///Atributo con las propiedades que utilizará el Equalable para comparar
  @override
  List<Object> get props => [token, username, name];

  String? getOrgaId() {
    if (Validators.validateToken(token)) {
      final payload = Jwt.parseJwt(token);

      if (payload.containsKey("orgaId") && payload["orgaId"].toString() != "") {
        return payload["orgaId"].toString();
      }
    }
    return null;
  }

  String? getUserId() {
    if (Validators.validateToken(token)) {
      final payload = Jwt.parseJwt(token);

      if (payload.containsKey("userId") && payload["userId"].toString() != "") {
        return payload["userId"].toString();
      }
    }
    return null;
  }
}
