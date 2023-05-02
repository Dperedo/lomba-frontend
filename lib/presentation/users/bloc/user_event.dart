import 'package:equatable/equatable.dart';
import 'package:lomba_frontend/presentation/users/bloc/user_state.dart';

import '../../../data/models/sort_model.dart';
import '../../../domain/entities/orgauser.dart';
import '../../../domain/entities/user.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class OnUserLoad extends UserEvent {
  final String userId;

  const OnUserLoad(this.userId);

  @override
  List<Object> get props => [userId];
}

class OnUserListLoad extends UserEvent {
  final String searchText;
  final String orgaId;
  final Map<String, int> fieldsOrder;
  final int pageIndex;
  final int pageSize;

  const OnUserListLoad(this.orgaId, this.searchText, this.fieldsOrder,
      this.pageIndex, this.pageSize);

  @override
  List<Object> get props =>
      [orgaId, searchText, fieldsOrder, pageIndex, pageSize];
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
  const OnUserPrepareForAdd();
}

class OnUserPrepareForEdit extends UserEvent {
  final User user;

  const OnUserPrepareForEdit(this.user);

  @override
  List<Object> get props => [user];
}

class OnUserValidate extends UserEvent {
  final String username;
  final String email;
  final UserAdding state;

  const OnUserValidate(this.username, this.email, this.state);

  @override
  List<Object> get props => [username, email];
}

class OnUserValidateEdit extends UserEvent {
  final String userId;
  final String username;
  final String email;
  final UserEditing state;

  const OnUserValidateEdit(this.userId, this.username, this.email, this.state);

  @override
  List<Object> get props => [username, email];
}

class OnUserEdit extends UserEvent {
  final String id;
  final String name;
  final String username;
  final String email;
  final bool enabled;
  final User user;

  const OnUserEdit(this.id, this.name, this.username, this.email, this.enabled, this.user);

  @override
  List<Object> get props => [id, name, username, email, enabled, user];
}

class OnUserEnable extends UserEvent {
  final String id;
  final String username;
  final bool enabled;

  const OnUserEnable(this.id, this.enabled, this.username);

  @override
  List<Object> get props => [id, enabled];
}

class OnUserDelete extends UserEvent {
  final String userId;
  final String username;

  const OnUserDelete(this.userId, this.username);

  @override
  List<Object> get props => [userId];
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

  const OnUserSaveNewPassword(this.password, this.user);

  @override
  List<Object> get props => [password];
}

class OnUserOrgaEdit extends UserEvent {
  final OrgaUser orgaUser;
  final List<String> roles;
  final bool enabled;

  const OnUserOrgaEdit(this.orgaUser, this.roles, this.enabled);

  @override
  List<Object> get props => [orgaUser, roles, enabled];
}

class OnUserOrgaDelete extends UserEvent {
  final OrgaUser orgaUser;

  const OnUserOrgaDelete(this.orgaUser);
  @override
  List<Object> get props => [orgaUser];
}

//OnUserListNotInOrga
class OnUserListNotInOrga extends UserEvent {
  final String searchText;
  final String orgaId;
  final Map<String, int> fieldsOrder;
  final int pageIndex;
  final int pageSize;

  const OnUserListNotInOrga(this.orgaId, this.searchText, this.fieldsOrder,
      this.pageIndex, this.pageSize);

  @override
  List<Object> get props =>
      [orgaId, searchText, fieldsOrder, pageIndex, pageSize];
}

//OnUserOrgaAdd
class OnUserOrgaAdd extends UserEvent {
  final String orgaId;
  final String userId;
  final List<String> roles;
  final bool enabled;

  const OnUserOrgaAdd(this.orgaId, this.userId, this.roles, this.enabled);

  @override
  List<Object> get props => [orgaId, userId, roles, enabled];
}

class OnUserStarter extends UserEvent {}
