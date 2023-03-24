import 'package:equatable/equatable.dart';

import '../../../core/validators.dart';
import '../../../domain/entities/user.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileStart extends ProfileState {
  final String message;

  const ProfileStart(this.message);

  @override
  List<Object> get props => [message];
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;
  const ProfileLoaded(this.user);
  @override
  List<Object> get props => [user];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}

class ProfileEditing extends ProfileState {
  final User user;
  bool existUserName = false;
  bool existEmail = false;
  ProfileEditing(bool existusername, bool existemail, this.user) {
    existUserName = existusername;
    existEmail = existemail;
  }

  ProfileEditing copyWith(bool existusername, bool existemail) {
    existUserName = existusername;
    existEmail = existemail;
    return this;
  }

  String? validateUsername(String username) {
    String? res = Validators.validateName(username);
    if (res == null) {
      if (existUserName) {
        return "El username ya existe";
      }
    } else {
      return res;
    }
    return null;
  }

  String? validateEmail(String email) {
    String? res = Validators.validateEmail(email);
    if (res == null) {
      if (existEmail) {
        return "El email ya existe";
      }
    } else {
      return res;
    }
    return null;
  }

  @override
  List<Object> get props => [existUserName, existEmail, user];
}
