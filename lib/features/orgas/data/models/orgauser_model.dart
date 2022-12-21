import '../../domain/entities/orgauser.dart';

///El [OrgaUserModel] representa una relación Organización y Usuario
///
///Extiende de [OrgaUser] sus atributos. El [OrgaUserModel] relaciona
///a las organizaciones con los usuarios, especificando además los roles
///comprendidos en esta relación.
class OrgaUserModel extends OrgaUser {
  const OrgaUserModel(
      {required userId,
      required orgaId,
      required roles,
      required enabled,
      required builtIn})
      : super(
            userId: userId,
            orgaId: orgaId,
            roles: roles,
            enabled: enabled,
            builtIn: builtIn);

  ///Crea un [OrgaUserModel] desde un Map (json)
  factory OrgaUserModel.fromJson(Map<String, dynamic> json) {
    return OrgaUserModel(
        userId: json["userId"],
        orgaId: json["orgaId"],
        roles: (json["roles"] as List<dynamic>).cast<String>(),
        enabled: json["enabled"],
        builtIn: json["builtIn"]);
  }

  ///Entrega un Map (json) desde el mismo objeto actual
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'orgaId': orgaId,
      'roles': roles,
      'enabled': enabled,
      'builtIn': builtIn
    };
  }

  ///Entrega la entidad [OrgaUser] desde el objeto actual.
  OrgaUser toEntity() => OrgaUser(
      userId: userId,
      orgaId: orgaId,
      roles: roles,
      enabled: enabled,
      builtIn: builtIn);

  ///Propiedades para la comparación de objetos con Equalable
  @override
  List<Object> get props => [userId, orgaId, roles, enabled, builtIn];
}
