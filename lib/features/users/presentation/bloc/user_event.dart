import 'package:equatable/equatable.dart';
import 'package:lomba_frontend/features/users/presentation/bloc/user_state.dart';

import '../../domain/entities/user.dart';

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
  final String password;

  const OnUserAdd(this.name, this.username, this.email, this.password);

  @override
  List<Object> get props => [name, username, email, password];
}

class OnUserPrepareForAdd extends UserEvent {
  @override
  List<Object> get props => [];
}

class OnUserValidate extends UserEvent {
  final String username;
  final String email;
  final UserAdding state;

  const OnUserValidate(this.username, this.email, this.state);

  @override
  List<Object> get props => [username, email];
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

class OnUserShowPasswordModifyForm extends UserEvent {
  final User user;

  const OnUserShowPasswordModifyForm(this.user);

  @override
  List<Object> get props => [user];
}

class OnUserSaveNewPassword extends UserEvent {
  final String password;
  final User user;

  const OnUserSaveNewPassword(this.password,this.user);

  @override
  List<Object> get props => [password];
}

