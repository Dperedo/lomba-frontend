import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class OnUserLoad extends UserEvent {
  final String id;

  const OnUserLoad(this.id);

  @override
  List<Object> get props => [id];
}

class OnUserListLoad extends UserEvent {
  final String orgaId;
  final String filter;
  final String fieldOrder;
  final double pageNumber;

  const OnUserListLoad(
      this.orgaId, this.filter, this.fieldOrder, this.pageNumber);

  @override
  List<Object> get props => [orgaId, filter, fieldOrder, pageNumber];
}

class OnUserAdd extends UserEvent {
  final String name;
  final String username;
  final String email;
  final String orgaId;
  final String password;
  final String role;

  const OnUserAdd(this.name, this.username, this.email, this.orgaId, this.password, this.role);

  @override
  List<Object> get props => [name, username, email, orgaId, password, role];
}

class OnUserPrepareForAdd extends UserEvent {

  @override
  List<Object> get props => [];
}

class OnUserEdit extends UserEvent {
  final String id;
  final String name;
  final String username;
  final String email;
  final bool enabled;

  const OnUserEdit(this.id, this.name, this.username, this.email, this.enabled);

  @override
  List<Object> get props => [id, name, username, email, enabled];
}

class OnUserEnable extends UserEvent {
  final String id;

  final bool enabled;

  const OnUserEnable(this.id, this.enabled);

  @override
  List<Object> get props => [id, enabled];
}

class OnUserDelete extends UserEvent {
  final String id;

  const OnUserDelete(this.id);

  @override
  List<Object> get props => [id];
}
