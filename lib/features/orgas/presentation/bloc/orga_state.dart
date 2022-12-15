import 'package:equatable/equatable.dart';

import '../../domain/entities/orga.dart';
import '../../domain/entities/orgauser.dart';

abstract class OrgaState extends Equatable {
  const OrgaState();

  @override
  List<Object> get props => [];
}

class OrgaStart extends OrgaState {}

class OrgaLoading extends OrgaState {}

class OrgaLoaded extends OrgaState {
  final Orga orga;
  const OrgaLoaded(this.orga);
  @override
  List<Object> get props => [orga];
}

class OrgaListLoaded extends OrgaState {
  final List<Orga> orgas;
  const OrgaListLoaded(this.orgas);
  @override
  List<Object> get props => [orgas];
}

class OrgaAdding extends OrgaState {}

class OrgaEditing extends OrgaState {
  final Orga orga;
  const OrgaEditing(this.orga);
  @override
  List<Object> get props => [orga];
}

class OrgaEnabling extends OrgaState {}

class OrgaDeleting extends OrgaState {}

class OrgaUserListLoaded extends OrgaState {
  final List<OrgaUser> orgaUsers;
  const OrgaUserListLoaded(this.orgaUsers);
  @override
  List<Object> get props => [orgaUsers];
}

class OrgaUserAdding extends OrgaState {}

class OrgaUserEditing extends OrgaState {
  final OrgaUser orgaUser;
  const OrgaUserEditing(this.orgaUser);
  @override
  List<Object> get props => [orgaUser];
}

class OrgaUserEnabling extends OrgaState {}

class OrgaUserDeleting extends OrgaState {}

class OrgaError extends OrgaState {
  final String message;

  const OrgaError(this.message);

  @override
  List<Object> get props => [message];
}
