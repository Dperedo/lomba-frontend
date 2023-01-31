import 'package:equatable/equatable.dart';

///Entidad de relación entre organización y usuario: [OrgaUser].
///
///[userId] identificador del usuario.
///[orgaId] identificador de la organización.
///[roles] es la lista de roles de la relación organización y usuario.
///[enabled] indica si la relación orga-user está habilitada o deshabilitada.
///[builtIn] si la relación orga-user es parte nativa del sistema.
class OrgaUser extends Equatable {
  const OrgaUser(
      {required this.userId,
      required this.orgaId,
      required this.roles,
      required this.enabled,
      required this.builtIn});

  final String userId;
  final String orgaId;
  final List<String> roles;
  final bool enabled;
  final bool builtIn;

  @override
  List<Object> get props => [userId, orgaId, roles, enabled, builtIn];
}
