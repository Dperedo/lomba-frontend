import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/users/add_user.dart';
import 'package:lomba_frontend/domain/usecases/users/delete_user.dart';
import 'package:lomba_frontend/domain/usecases/users/enable_user.dart';
import 'package:lomba_frontend/domain/usecases/users/exists_user.dart';
import 'package:lomba_frontend/domain/usecases/users/get_user.dart';
import 'package:lomba_frontend/domain/usecases/users/update_user.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/models/session_model.dart';
import '../../../domain/usecases/local/get_session_status.dart';
import '../../../domain/usecases/login/register_user.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/users/get_users.dart';
import '../../../domain/usecases/users/update_user_password.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AddUser _addUser;
  final DeleteUser _deleteUser;
  final EnableUser _enableUser;
  final GetUser _getUser;
  final GetUsers _getUsers;
  final UpdateUser _updateUser;
  final RegisterUser _registerUser;
  final GetSession _getSession;
  final ExistsUser _existsUser;
  final UpdateUserPassword _updateUserPassword;

  UserBloc(
      this._addUser,
      this._deleteUser,
      this._enableUser,
      this._getUser,
      this._getUsers,
      this._updateUser,
      this._registerUser,
      this._getSession,
      this._existsUser,
      this._updateUserPassword)
      : super(const UserStart("")) {
    on<OnUserLoad>(
      (event, emit) async {
        emit(UserLoading());
        final result = await _getUser.execute(event.id);

        result.fold(
            (l) => emit(UserError(l.message)), (r) => {emit(UserLoaded(r, ""))});
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    on<OnUserListLoad>(
      (event, emit) async {
        emit(UserLoading());
        final result = await _getUsers.execute(
            event.orgaId, event.filter, event.fieldOrder, event.pageNumber, 10);

        result.fold((l) => emit(UserError(l.message)),
            (r) => {emit(UserListLoaded(r))});
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    on<OnUserAdd>((event, emit) async {
      emit(UserLoading());
      var auth = const SessionModel(token: "", username: "", name: "");

      final session = await _getSession.execute();

      session.fold((l) => emit(UserError(l.message)), (r) => {auth = r});

      var role = "user";

      final result = await _registerUser.execute(event.name, event.username,
          event.email, auth.getOrgaId()!, event.password, role);

      result.fold(
          (l) => emit(UserError(l.message)), (r) => {emit(UserStart(" El usuario ${event.username} fue creado"))});
    });

    on<OnUserPrepareForAdd>((event, emit) async {
      emit(UserAdding(false, false));
    });

    on<OnUserPrepareForEdit>((event, emit) async {
      emit(UserEditing(false, false, event.user));
    });

    on<OnUserValidate>((event, emit) async {
      String userNoId = '';
      if (event.username != "" || event.email != "") {
        final result =
            await _existsUser.execute(userNoId, event.username, event.email);

        result.fold((l) => emit(UserError(l.message)), (r) {
          if (r != null) {
            event.state.existEmail = (r.email == event.email);
            event.state.existUserName = (r.username == event.username);
          } else {
            event.state.existEmail = false;
            event.state.existUserName = false;
          }
        });
      }
    });

    on<OnUserValidateEdit>((event, emit) async {
      if (event.username != "" || event.email != "") {
        final result = await _existsUser.execute(
            event.userId, event.username, event.email);

        result.fold((l) => emit(UserError(l.message)), (r) {
          if (r != null) {
            event.state.existEmail = (r.email == event.email);
            event.state.existUserName = (r.username == event.username);
          } else {
            event.state.existEmail = false;
            event.state.existUserName = false;
          }
        });
      }
    });

    on<OnUserEdit>((event, emit) async {
      emit(UserLoading());

      final user = User(
          id: event.id,
          name: event.name,
          username: event.username,
          email: event.email,
          enabled: event.enabled,
          builtIn: false);

      final result = await _updateUser.execute(event.id, user);
      result.fold(
          (l) => emit(UserError(l.message)), (r) => {emit(UserStart(" El usuario ${event.username} fue actualizado"))});
    });

    on<OnUserEnable>((event, emit) async {
      emit(UserLoading());

      final result = await _enableUser.execute(event.id, event.enabled);
      result.fold(
          (l) => emit(UserError(l.message)), (r) => {emit(UserLoaded(r, 
          (event.enabled?" El usuario ${event.username} fue habilitado":" El usuario ${event.username} fue deshabilitado")))});
    });
    on<OnUserDelete>((event, emit) async {
      emit(UserLoading());

      final result = await _deleteUser.execute(event.id);
      result.fold(
          (l) => emit(UserError(l.message)), (r) => {emit(UserStart(" El usuario ${event.username} fue eliminado"))});
    });
    on<OnUserShowPasswordModifyForm>((event, emit) async {
      emit(UserLoading());

      emit(UserUpdatePassword(event.user));
    });
    on<OnUserSaveNewPassword>((event, emit) async {
      emit(UserLoading());
      final result =
          await _updateUserPassword.execute(event.user.id, event.password);

      result.fold((l) => emit(UserError(l.message)),
          (r) => {emit(UserLoaded(event.user, " Contraseña Modificada"))});
    });
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
