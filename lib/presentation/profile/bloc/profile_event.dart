import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:lomba_frontend/domain/entities/user.dart';
import 'package:lomba_frontend/presentation/profile/bloc/profile_state.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => [];
}

class OnProfileLoad extends ProfileEvent {
  final String? userId;
  final String? orgaId;

  const OnProfileLoad(this.userId, this.orgaId);

  @override
  List<Object> get props => [userId!, orgaId!];
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

class OnProfileSaveNewPassword extends ProfileEvent {
  final String password;
  final User user;

  const OnProfileSaveNewPassword(this.password, this.user);

  @override
  List<Object> get props => [password, user];
}

class OnProfileShowPasswordModifyForm extends ProfileEvent {
  final User user;

  const OnProfileShowPasswordModifyForm(this.user);
  @override
  List<Object> get props => [user];
}

class OnProfileSaveImagen extends ProfileEvent {
  final User user;
  final Uint8List image;
  final String? imageUrl;
  final String? cloudFileId;
  final String? imageUrlThumbnail;
  final String? cloudFileIdThumbnail;

  const OnProfileSaveImagen(this.user, this.image, this.imageUrl, this.cloudFileId, this.imageUrlThumbnail, this.cloudFileIdThumbnail);

  @override
  List<Object> get props => [user, image];
}

class OnProfileStarter extends ProfileEvent {}
