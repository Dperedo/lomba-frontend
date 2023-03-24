import 'package:equatable/equatable.dart';
import 'package:lomba_frontend/domain/entities/user.dart';
import 'package:lomba_frontend/presentation/profile/bloc/profile_state.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => [];
}

class OnProfileLoad extends ProfileEvent {
  final String? id;

  const OnProfileLoad(this.id);

  @override
  List<Object> get props => [id!];
}

class OnProfileEdit extends ProfileEvent {
  final String id;
  final String name;
  final String username;
  final String email;

  const OnProfileEdit(this.id, this.name, this.username, this.email);

  @override
  List<Object> get props => [id, name, username, email];
}

class OnProfileEditPrepare extends ProfileEvent {
  final User user;

  const OnProfileEditPrepare(this.user);

  @override
  List<Object> get props => [user];
}

class OnProfileValidate extends ProfileEvent {
  final String userId;
  final String username;
  final String email;
  final ProfileEditing state;

  const OnProfileValidate(this.userId, this.username, this.email, this.state);

  @override
  List<Object> get props => [username, email];
}

class OnProfileStarter extends ProfileEvent {}
