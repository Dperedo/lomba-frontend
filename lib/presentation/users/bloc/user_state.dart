import 'package:equatable/equatable.dart';

import '../../../core/validators.dart';
import '../../../domain/entities/orgauser.dart';
import '../../../domain/entities/user.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];

  //get message => null;
}

class UserStart extends UserState {
  final String message;
  const UserStart(this.message);
  @override
  List<Object> get props => [message];
}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User user;
  final OrgaUser orgaUser;
  final String message;
  const UserLoaded(this.user, this.orgaUser, this.message);
  @override
  List<Object> get props => [user, orgaUser, message];
}

class UserListLoaded extends UserState {
  final List<User> users;
  final String orgaId;
  final String searchText;
  final Map<String, int> fieldsOrder;
  final int pageIndex;
  final int pageSize;
  final int itemCount;
  final int totalItems;
  final int totalPages;
  const UserListLoaded(
      this.users,
      this.orgaId,
      this.searchText,
      this.fieldsOrder,
      this.pageIndex,
      this.pageSize,
      this.itemCount,
      this.totalItems,
      this.totalPages);
  @override
  List<Object> get props => [
        users,
        orgaId,
        searchText,
        fieldsOrder,
        pageIndex,
        pageSize,
        itemCount,
        totalItems,
        totalPages
      ];
}

class UserListNotInOrgaLoaded extends UserState {
  final List<User> users;
  final OrgaUser orgaUser;
  final String orgaId;
  final String searchText;
  final Map<String, int> fieldsOrder;
  final int pageIndex;
  final int pageSize;
  final int itemCount;
  final int totalItems;
  final int totalPages;
  const UserListNotInOrgaLoaded(
      this.users,
      this.orgaUser,
      this.orgaId,
      this.searchText,
      this.fieldsOrder,
      this.pageIndex,
      this.pageSize,
      this.itemCount,
      this.totalItems,
      this.totalPages);
  @override
  List<Object> get props => [
        users,
        orgaUser,
        orgaId,
        searchText,
        fieldsOrder,
        pageIndex,
        pageSize,
        itemCount,
        totalItems,
        totalPages
      ];
}

class UserAdding extends UserState {
  bool existUserName = false;
  bool existEmail = false;
  UserAdding(bool existusername, bool existemail) {
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
  UserEditing(bool existusername, bool existemail, this.user) {
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
