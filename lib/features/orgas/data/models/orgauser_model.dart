import '../../domain/entities/orgauser.dart';

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

  factory OrgaUserModel.fromJson(Map<String, dynamic> json) {
    return OrgaUserModel(
        userId: json["userId"],
        orgaId: json["orgaId"],
        roles: (json["roles"] as List<dynamic>).cast<String>(),
        enabled: json["enabled"],
        builtIn: json["builtIn"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'orgaId': orgaId,
      'roles': roles,
      'enabled': enabled,
      'builtIn': builtIn
    };
  }

  OrgaUser toEntity() => OrgaUser(
      userId: userId,
      orgaId: orgaId,
      roles: roles,
      enabled: enabled,
      builtIn: builtIn);

  @override
  List<Object> get props => [userId, orgaId, roles, enabled, builtIn];
}
