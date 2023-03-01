import 'package:equatable/equatable.dart';

import '../../../data/models/sort_model.dart';

///Interfaz del evento de relación orga-user
abstract class OrgaUserEvent extends Equatable {
  const OrgaUserEvent();
}

///Evento inicial
class OnOrgaUserStarter extends OrgaUserEvent {
  const OnOrgaUserStarter();

  @override
  List<Object> get props => [];
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
  final String user;

  const OnOrgaUserAdd(this.orgaId, this.userId, this.roles, this.enabled, this.user);

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

///Evento para mostrar lista de usuarios que no están en la organización
class OnOrgaUserListUserNotInOrgaForAdd extends OrgaUserEvent {
  final String orgaId;
  final SortModel sortFields;
  final int pageNumber;
  final int pageSize;

  const OnOrgaUserListUserNotInOrgaForAdd(
      this.orgaId, this.sortFields, this.pageNumber, this.pageSize);

  @override
  List<Object> get props => [orgaId, sortFields, pageNumber, pageSize];
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
  final String user;

  const OnOrgaUserDelete(this.orgaId, this.userId, this.user);

  @override
  List<Object> get props => [orgaId, userId];
}
