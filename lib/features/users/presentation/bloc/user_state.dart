
import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserStart extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User user;
  const UserLoaded(this.user);
  @override
  List<Object> get props => [user];
}

class UserListLoaded extends UserState {
  final List<User> users;
  const UserListLoaded(this.users);
  @override
  List<Object> get props => [users];
}

class UserAdding extends UserState {}

class UserEditing extends UserState {
  final User user;
  const UserEditing(this.user);
  @override
  List<Object> get props => [user];
}

class UserEnabling extends UserState {}

class UserDeleting extends UserState {}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object> get props => [message];
}

class ModifyUserPassword extends UserState {
  final User user;
  const ModifyUserPassword(this.user);
  @override
  List<Object> get props => [user];
}
