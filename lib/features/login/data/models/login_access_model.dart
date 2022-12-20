import 'package:lomba_frontend/features/login/domain/entities/login_access.dart';

///El [LoginAccessModel] consigue la información de acceso del usuario
///obtenida desde el backend. Con esta información luego se creará el
///[SessionModel]
class LoginAccessModel extends LoginAccess {
  const LoginAccessModel(
      {required String token, required String username, required String name})
      : super(token: token, username: username, name: name);

  ///Crea un LoginAccessModel desde un Map (json)
  factory LoginAccessModel.fromJson(Map<String, dynamic> json) {
    return LoginAccessModel(
        token: json["token"], username: json["username"], name: json["name"]);
  }

  ///Entrega un Map (json) desde el mismo objeto actual
  Map<String, dynamic> toJson() {
    return {'token': token, 'username': username, 'name': name};
  }

  ///Entrega la entidad [LoginAccess] desde el objeto actual.
  LoginAccess toEntity() =>
      LoginAccess(token: token, username: username, name: name);

  ///Propiedades para la comparación de objetos con Equalable
  @override
  List<Object> get props => [token, username, name];
}
