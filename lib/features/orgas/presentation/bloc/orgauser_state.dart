import 'package:equatable/equatable.dart';

import '../../../users/domain/entities/user.dart';
import '../../domain/entities/orgauser.dart';

///Interfaz de estado Bloc de usuarios
abstract class OrgaUserState extends Equatable {
  const OrgaUserState();

  @override
  List<Object> get props => [];
}

///Estado inicial de la lista en orgausers
class OrgaUserStart extends OrgaUserState {}

///Estado que indica que el proceso se está ejecutando
class OrgaUserLoading extends OrgaUserState {}

///Estado con la lista de orga-users cargada
class OrgaUserListLoaded extends OrgaUserState {
  final List<User> users;
  final List<OrgaUser> orgaUsers;
  final String orgaId;
  const OrgaUserListLoaded(this.orgaId, this.users, this.orgaUsers);
  @override
  List<Object> get props => [users, orgaId, orgaUsers];
}

///Estado con la lista de orga-users cargada
class OrgaUserListUserNotInOrgaLoaded extends OrgaUserState {
  final List<User> users;
  final String orgaId;
  const OrgaUserListUserNotInOrgaLoaded(this.orgaId, this.users);
  @override
  List<Object> get props => [users, orgaId];
}

///Estado para mostrar las opciones que permiten agregar una nueva relación
class OrgaUserAdding extends OrgaUserState {}

///Estado para mostrar opciones de edición de una relación
class OrgaUserEditing extends OrgaUserState {
  final OrgaUser orgaUser;
  const OrgaUserEditing(this.orgaUser);
  @override
  List<Object> get props => [orgaUser];
}

///Estado para mostrar las opciones de habilitación de relación orga-user
class OrgaUserEnabling extends OrgaUserState {}

///Estado para mostrar las opciones de eliminación de orga-users
class OrgaUserDeleting extends OrgaUserState {}

///Estado para mostrar cualquier problema originado en un procedimiento
class OrgaUserError extends OrgaUserState {
  final String message;

  const OrgaUserError(this.message);

  @override
  List<Object> get props => [message];
}
