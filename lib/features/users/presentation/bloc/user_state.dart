
import 'package:equatable/equatable.dart';

import '../../../../core/validators.dart';
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

class UserAdding extends UserState {
  bool existUserName = false;
  bool existEmail = false;
  UserAdding(bool existusername, bool existemail){
    existUserName = existusername;
    existEmail = existemail;
  }

  UserAdding copyWith(bool existusername, bool existemail) {
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
  List<Object> get props => [existUserName, existEmail];
}

class UserEditing extends UserState {
  final User user;
  bool existUserName = false;
  bool existEmail = false;
  UserEditing(bool existusername, bool existemail, this.user){
    existUserName = existusername;
    existEmail = existemail;
  }

  UserEditing copyWith(bool existusername, bool existemail) {
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
    } 
    else {
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

class UserEnabling extends UserState {}

class UserDeleting extends UserState {}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object> get props => [message];
}

class UserUpdatePassword extends UserState {
  final User user;
  const UserUpdatePassword(this.user);
  @override
  List<Object> get props => [user];
}
