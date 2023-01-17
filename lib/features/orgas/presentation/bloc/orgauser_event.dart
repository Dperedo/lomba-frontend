import 'package:equatable/equatable.dart';

///Interfaz del evento de relación orga-user
abstract class OrgaUserEvent extends Equatable {
  const OrgaUserEvent();

  @override
  List<Object?> get props => [];
}

///Evento para obtener la lista de relaciones de orga-user
class OnOrgaUserListLoad extends OrgaUserEvent {
  final String id;

  const OnOrgaUserListLoad(this.id);

  @override
  List<Object> get props => [id];
}

///Evento para guardar una nueva relación orga-user
class OnOrgaUserAdd extends OrgaUserEvent {
  final String orgaId;
  final String userId;
  final List<String> roles;
  final bool enabled;

  const OnOrgaUserAdd(this.orgaId, this.userId, this.roles, this.enabled);

  @override
  List<Object> get props => [orgaId, userId, roles, enabled];
}

///Evento para enviar a editar una relación orga-user
class OnOrgaUserEdit extends OrgaUserEvent {
  final String orgaId;
  final String userId;
  final List<String> roles;
  final bool enabled;

  const OnOrgaUserEdit(this.orgaId, this.userId, this.roles, this.enabled);

  @override
  List<Object> get props => [orgaId, userId, roles, enabled];
}

///Evento para mostrar ventana de edición de asociación orga-user /role
class OnOrgaUserPrepareForEdit extends OrgaUserEvent {
  final String orgaId;
  final String userId;

  const OnOrgaUserPrepareForEdit(this.orgaId, this.userId);

  @override
  List<Object> get props => [orgaId, userId];
}

///Evento que procede a habilitar o deshabilitar una relación orga-user
class OnOrgaUserEnable extends OrgaUserEvent {
  final String orgaId;
  final String userId;

  final bool enabled;

  const OnOrgaUserEnable(this.orgaId, this.userId, this.enabled);

  @override
  List<Object> get props => [orgaId, userId, enabled];
}

///Evevento que procede a eliminar una relación orga-user
class OnOrgaUserDelete extends OrgaUserEvent {
  final String orgaId;
  final String userId;

  const OnOrgaUserDelete(this.orgaId, this.userId);

  @override
  List<Object> get props => [orgaId, userId];
}
