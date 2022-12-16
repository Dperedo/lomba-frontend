import 'package:equatable/equatable.dart';

import '../../domain/entities/orgauser.dart';

abstract class OrgaUserState extends Equatable {
  const OrgaUserState();

  @override
  List<Object> get props => [];
}

class OrgaUserStart extends OrgaUserState {}

class OrgaUserLoading extends OrgaUserState {}

class OrgaUserListLoaded extends OrgaUserState {
  final List<OrgaUser> orgaUsers;
  const OrgaUserListLoaded(this.orgaUsers);
  @override
  List<Object> get props => [orgaUsers];
}

class OrgaUserAdding extends OrgaUserState {}

class OrgaUserEditing extends OrgaUserState {
  final OrgaUser orgaUser;
  const OrgaUserEditing(this.orgaUser);
  @override
  List<Object> get props => [orgaUser];
}

class OrgaUserEnabling extends OrgaUserState {}

class OrgaUserDeleting extends OrgaUserState {}

class OrgaUserError extends OrgaUserState {
  final String message;

  const OrgaUserError(this.message);

  @override
  List<Object> get props => [message];
}
