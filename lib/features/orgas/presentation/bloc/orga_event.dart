import 'package:equatable/equatable.dart';

abstract class OrgaEvent extends Equatable {
  const OrgaEvent();

  @override
  List<Object?> get props => [];
}

class OnOrgaLoad extends OrgaEvent {
  final String id;

  const OnOrgaLoad(this.id);

  @override
  List<Object> get props => [id];
}

class OnOrgaListLoad extends OrgaEvent {
  final String filter;
  final String fieldOrder;
  final double pageNumber;

  const OnOrgaListLoad(this.filter, this.fieldOrder, this.pageNumber);

  @override
  List<Object> get props => [filter, fieldOrder, pageNumber];
}

class OnOrgaAdd extends OrgaEvent {
  final String name;
  final String code;
  final bool enabled;

  const OnOrgaAdd(this.name, this.code, this.enabled);

  @override
  List<Object> get props => [name, code, enabled];
}

class OnOrgaEdit extends OrgaEvent {
  final String id;
  final String name;
  final String code;
  final bool enabled;

  const OnOrgaEdit(this.id, this.name, this.code, this.enabled);

  @override
  List<Object> get props => [id, name, code, enabled];
}

class OnOrgaEnable extends OrgaEvent {
  final String id;

  final bool enabled;

  const OnOrgaEnable(this.id, this.enabled);

  @override
  List<Object> get props => [id, enabled];
}

class OnOrgaDelete extends OrgaEvent {
  final String id;

  const OnOrgaDelete(this.id);

  @override
  List<Object> get props => [id];
}

class OnOrgaUserListLoad extends OrgaEvent {
  final String id;

  const OnOrgaUserListLoad(this.id);

  @override
  List<Object> get props => [id];
}

class OnOrgaUserAdd extends OrgaEvent {
  final String orgaId;
  final String userId;
  final List<String> roles;
  final bool enabled;

  const OnOrgaUserAdd(this.orgaId, this.userId, this.roles, this.enabled);

  @override
  List<Object> get props => [orgaId, userId, roles, enabled];
}

class OnOrgaUserEdit extends OrgaEvent {
  final String orgaId;
  final String userId;
  final List<String> roles;
  final bool enabled;

  const OnOrgaUserEdit(this.orgaId, this.userId, this.roles, this.enabled);

  @override
  List<Object> get props => [orgaId, userId, roles, enabled];
}

class OnOrgaUserEnable extends OrgaEvent {
  final String orgaId;
  final String userId;

  final bool enabled;

  const OnOrgaUserEnable(this.orgaId, this.userId, this.enabled);

  @override
  List<Object> get props => [orgaId, userId, enabled];
}

class OnOrgaUserDelete extends OrgaEvent {
  final String orgaId;
  final String userId;

  const OnOrgaUserDelete(this.orgaId, this.userId);

  @override
  List<Object> get props => [orgaId, userId];
}
