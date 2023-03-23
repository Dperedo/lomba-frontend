import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/users/add_user.dart';
import 'package:lomba_frontend/domain/usecases/users/delete_user.dart';
import 'package:lomba_frontend/domain/usecases/users/enable_user.dart';
import 'package:lomba_frontend/domain/usecases/users/exists_user.dart';
import 'package:lomba_frontend/domain/usecases/users/get_user.dart';
import 'package:lomba_frontend/domain/usecases/users/update_user.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/models/session_model.dart';
import '../../../domain/entities/orgauser.dart';
import '../../../domain/usecases/local/get_session_status.dart';
import '../../../domain/usecases/login/register_user.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/orgas/add_orgauser.dart';
import '../../../domain/usecases/orgas/delete_orgauser.dart';
import '../../../domain/usecases/orgas/get_orgauser.dart';
import '../../../domain/usecases/orgas/get_orgausers.dart';
import '../../../domain/usecases/orgas/update_orgauser.dart';
import '../../../domain/usecases/users/get_users.dart';
import '../../../domain/usecases/users/get_users_notin_orga.dart';
import '../../../domain/usecases/users/update_user_password.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final DeleteUser _deleteUser;
  final EnableUser _enableUser;
  final GetUser _getUser;
  final GetUsers _getUsers;
  final UpdateUser _updateUser;
  final RegisterUser _registerUser;
  final GetSession _getSession;
  final ExistsUser _existsUser;
  final UpdateUserPassword _updateUserPassword;
  final GetOrgaUser _getOrgaUser;
  final UpdateOrgaUser _updateOrgaUser;
  final DeleteOrgaUser _deleteOrgaUser;
  final GetUsersNotInOrga _getUsersNotInOrga;
  final AddOrgaUser _addOrgaUser;

  UserBloc(
      this._deleteUser,
      this._enableUser,
      this._getUser,
      this._getUsers,
      this._updateUser,
      this._registerUser,
      this._getSession,
      this._existsUser,
      this._updateUserPassword,
      this._getOrgaUser,
      this._updateOrgaUser,
      this._deleteOrgaUser,
      this._getUsersNotInOrga,
      this._addOrgaUser)
      : super(const UserStart("")) {
    on<OnUserStarter>((event, emit) => emit(const UserStart('')));

    on<OnUserLoad>(
      (event, emit) async {
        emit(UserLoading());

        var user = const User(
          id: '',
          name: '',
          username: '',
          email: '',
          enabled: true,
          builtIn: true);
        final result = await _getUser.execute(event.userId);
        result.fold((l) => emit(UserError(l.message)),
            (r) => user = r);

        
        var auth = const SessionModel(token: "", username: "", name: "");
        final session = await _getSession.execute();
        session.fold((l) => emit(UserError(l.message)), (r) => {auth = r});
        final orgaId = auth.getOrgaId();

        List<OrgaUser> listOrgaUsers = [];
        final resultOrgaUser = await _getOrgaUser.execute(orgaId!,event.userId);
        resultOrgaUser.fold((l) => emit(UserError(l.message)), (r) {
          listOrgaUsers = r;
          emit(UserLoaded(user, listOrgaUsers[0], ''));});
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

      result.fold((l) => emit(UserError(l.message)),
          (r) => {emit(UserStart(" El usuario ${event.username} fue creado"))});
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
          (l) => emit(UserError(l.message)),
          (r) => {
                emit(UserStart(" El usuario ${event.username} fue actualizado"))
              });
    });

    on<OnUserEnable>((event, emit) async {
      emit(UserLoading());

      //-----------------
      var auth = const SessionModel(token: "", username: "", name: "");
        final session = await _getSession.execute();
        session.fold((l) => emit(UserError(l.message)), (r) => {auth = r});
        final orgaId = auth.getOrgaId();

        List<OrgaUser> listOrgaUsers = [];
        final resultOrgaUser = await _getOrgaUser.execute(orgaId!,event.id);
        resultOrgaUser.fold((l) => emit(UserError(l.message)), (r) =>listOrgaUsers = r);
      //-----------------

      final result = await _enableUser.execute(event.id, event.enabled);
      result.fold(
          (l) => emit(UserError(l.message)),
          (r) => {
                emit(UserLoaded(
                    r,
                    listOrgaUsers[0],
                    (event.enabled
                        ? " El usuario ${event.username} fue habilitado"
                        : " El usuario ${event.username} fue deshabilitado")))
              });
    });
    on<OnUserDelete>((event, emit) async {
      emit(UserLoading());

      final result = await _deleteUser.execute(event.userId);
      result.fold(
          (l) => emit(UserError(l.message)),
          (r) =>
              {emit(UserStart(" El usuario ${event.username} fue eliminado"))});
    });
    on<OnUserShowPasswordModifyForm>((event, emit) async {
      emit(UserLoading());

      emit(UserUpdatePassword(event.user));
    });
    on<OnUserSaveNewPassword>((event, emit) async {
      emit(UserLoading());

      //-----------------
      var auth = const SessionModel(token: "", username: "", name: "");
      final session = await _getSession.execute();
      session.fold((l) => emit(UserError(l.message)), (r) => {auth = r});
      final orgaId = auth.getOrgaId();

      List<OrgaUser> listOrgaUsers = [];
      final resultOrgaUser = await _getOrgaUser.execute(orgaId!,event.user.id);
      resultOrgaUser.fold((l) => emit(UserError(l.message)), (r) =>listOrgaUsers = r);
      //-----------------

      final result =
          await _updateUserPassword.execute(event.user.id, event.password);

      result.fold((l) => emit(UserError(l.message)),
          (r) => {emit(UserLoaded(event.user, listOrgaUsers[0], " Contraseña Modificada"))});
    });
    on<OnUserOrgaEdit>((event, emit) async {
      emit(UserLoading());

      var orgaUser = OrgaUser(
          orgaId: event.orgaUser.orgaId,
          userId: event.orgaUser.userId,
          roles: event.roles,
          enabled: event.enabled,
          builtIn: false);

      bool isUpdated = false;

      final result =
          await _updateOrgaUser.execute(event.orgaUser.orgaId, event.orgaUser.userId, orgaUser);
      result.fold(
          (l) => emit(UserError(l.message)), (r) => {isUpdated = true});

      if (isUpdated) {
        final resUser = await _getUser.execute(event.orgaUser.userId);

        final resultOU = await _getOrgaUser.execute(event.orgaUser.orgaId, event.orgaUser.userId);

        var user = const User(
          id: '',
          name: '',
          username: '',
          email: '',
          enabled: false,
          builtIn: false);
        resUser.fold(
            (l) => emit(UserError(l.message)), (r) => {user = r});

        List<OrgaUser> listOrgaUsers = [];
        resultOU.fold(
            (l) => emit(UserError(l.message)), (r) => {listOrgaUsers = r});

        emit(UserLoaded(user, listOrgaUsers[0], ''));
      }
    });
    on<OnUserOrgaDelete>((event, emit) async {
      emit(UserLoading());

      //-------------
      var user = const User(
          id: '',
          name: '',
          username: '',
          email: '',
          enabled: false,
          builtIn: false);
      final resUser = await _getUser.execute(event.orgaUser.userId);
      resUser.fold((l) => emit(UserError(l.message)), (r) => {user = r});
      //-------------

      bool isDeleted = false;

      final result = await _deleteOrgaUser.execute(event.orgaUser.orgaId, event.orgaUser.userId);
      result.fold(
          (l) => emit(UserError(l.message)), (r) => {isDeleted = r});

      if (isDeleted) {
        emit(UserLoaded(
          user,
          event.orgaUser,
            " El Usuario ${user.name} fue desasociado de la organización"));
      }
    });

    on<OnUserListNotInOrga>(
      (event, emit) async {
        emit(UserLoading());

        //-----------------
        var auth = const SessionModel(token: "", username: "", name: "");
        final session = await _getSession.execute();
        session.fold((l) => emit(UserError(l.message)), (r) => {auth = r});
        final orgaId = auth.getOrgaId();

        var orgaUser = OrgaUser(
          orgaId: orgaId!,
          userId: '',
          roles: [],
          enabled: true,
          builtIn: false);
        //-----------------

        final result = await _getUsersNotInOrga.execute(
            orgaId!, event.filter, event.pageNumber, 10);

        result.fold((l) => emit(UserError(l.message)),
            (r) => {emit(UserListNotInOrgaLoaded(r, orgaUser))});
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );
    on<OnUserOrgaAdd>((event, emit) async {
      emit(UserLoading());

      var name = '';
      final resUser = await _getUser.execute(event.userId);
      resUser.fold((l) => emit(UserError(l.message)), (r) => name = r.name);

      final result = await _addOrgaUser.execute(
          event.orgaId, event.userId, event.roles, event.enabled);

      result.fold(
          (l) => emit(UserError(l.message)),
          (r) => {
                emit(UserStart(
                    " El usuario $name fue agregado a la organización"))
              });
    });
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
