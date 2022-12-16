import 'package:equatable/equatable.dart';

abstract class OrgaUserEvent extends Equatable {
  const OrgaUserEvent();

  @override
  List<Object?> get props => [];
}

class OnOrgaUserListLoad extends OrgaUserEvent {
  final String id;

  const OnOrgaUserListLoad(this.id);

  @override
  List<Object> get props => [id];
}

class OnOrgaUserAdd extends OrgaUserEvent {
  final String orgaId;
  final String userId;
  final List<String> roles;
  final bool enabled;

  const OnOrgaUserAdd(this.orgaId, this.userId, this.roles, this.enabled);

  @override
  List<Object> get props => [orgaId, userId, roles, enabled];
}

class OnOrgaUserEdit extends OrgaUserEvent {
  final String orgaId;
  final String userId;
  final List<String> roles;
  final bool enabled;

  const OnOrgaUserEdit(this.orgaId, this.userId, this.roles, this.enabled);

  @override
  List<Object> get props => [orgaId, userId, roles, enabled];
}

class OnOrgaUserEnable extends OrgaUserEvent {
  final String orgaId;
  final String userId;

  final bool enabled;

  const OnOrgaUserEnable(this.orgaId, this.userId, this.enabled);

  @override
  List<Object> get props => [orgaId, userId, enabled];
}

class OnOrgaUserDelete extends OrgaUserEvent {
  final String orgaId;
  final String userId;

  const OnOrgaUserDelete(this.orgaId, this.userId);

  @override
  List<Object> get props => [orgaId, userId];
}
