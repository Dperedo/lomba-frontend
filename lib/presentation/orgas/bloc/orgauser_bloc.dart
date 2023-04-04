import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/orgas/add_orgauser.dart';
import 'package:lomba_frontend/domain/usecases/orgas/delete_orgauser.dart';
import 'package:lomba_frontend/domain/usecases/orgas/enable_orgauser.dart';
import 'package:lomba_frontend/domain/usecases/orgas/get_orgausers.dart';
import 'package:lomba_frontend/domain/usecases/orgas/update_orgauser.dart';
import 'package:lomba_frontend/domain/usecases/users/get_users_notin_orga.dart';

import '../../../domain/entities/orgauser.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/users/get_users.dart';
import 'orgauser_event.dart';
import 'orgauser_state.dart';

///BLOC de la relación entre organizaciones y usuarios.
///
///Considera todos los casos de uso de la relación orga-user
class OrgaUserBloc extends Bloc<OrgaUserEvent, OrgaUserState> {
  final AddOrgaUser _addOrgaUser;
  final DeleteOrgaUser _deleteOrgaUser;
  final EnableOrgaUser _enableOrgaUser;
  final GetOrgaUsers _getOrgaUsers;
  final UpdateOrgaUser _updateOrgaUser;
  final GetUsers _getUsers;
  final GetUsersNotInOrga _getUsersNotInOrga;

  OrgaUserBloc(
      this._addOrgaUser,
      this._deleteOrgaUser,
      this._enableOrgaUser,
      this._getOrgaUsers,
      this._updateOrgaUser,
      this._getUsers,
      this._getUsersNotInOrga)
      : super(const OrgaUserStart("")) {
    on<OnOrgaUserListLoad>((event, emit) async {
      emit(OrgaUserLoading());
      final result = await _getUsers.execute(event.searchText, event.orgaId,
          event.fieldsOrder, event.pageIndex, event.pageSize);

      final resultOU = await _getOrgaUsers.execute(event.orgaId);

      List<OrgaUser> listOrgaUsers = [];
      resultOU.fold(
          (l) => emit(OrgaUserError(l.message)), (r) => {listOrgaUsers = r});

      result.fold((l) => emit(OrgaUserError(l.message)), (r) {
        emit(OrgaUserListLoaded(
            event.orgaId,
            r.items,
            listOrgaUsers,
            event.searchText,
            event.fieldsOrder,
            event.pageIndex,
            event.pageSize,
            r.currentItemCount,
            r.totalItems ?? 0,
            r.totalPages ?? 1));
      });
    });
    on<OnOrgaUserAdd>((event, emit) async {
      emit(OrgaUserLoading());

      final result = await _addOrgaUser.execute(
          event.orgaId, event.userId, event.roles, event.enabled);

      result.fold(
          (l) => emit(OrgaUserError(l.message)),
          (r) => {
                emit(OrgaUserStart(
                    " El usuario ${event.user} fue agregado a la organización"))
              });
    });
    on<OnOrgaUserEdit>((event, emit) async {
      emit(OrgaUserLoading());

      final orgaUser = OrgaUser(
          orgaId: event.orgaId,
          userId: event.userId,
          roles: event.roles,
          enabled: event.enabled,
          builtIn: false);

      bool isUpdated = false;

      final result =
          await _updateOrgaUser.execute(event.orgaId, event.userId, orgaUser);
      result.fold(
          (l) => emit(OrgaUserError(l.message)), (r) => {isUpdated = true});

      if (isUpdated) {
        final resultOU = await _getOrgaUsers.execute(event.orgaId);
        final resUsers = await _getUsers.execute(
            '', event.orgaId, const <String, int>{"email": 1}, 1, 10);

        List<OrgaUser> listOrgaUsers = [];
        resultOU.fold(
            (l) => emit(OrgaUserError(l.message)), (r) => {listOrgaUsers = r});

        resUsers.fold((l) => emit(OrgaUserError(l.message)), (r) {
          emit(OrgaUserListLoaded(
              event.orgaId,
              r.items,
              listOrgaUsers,
              '',
              const <String, int>{"email": 1},
              1,
              10,
              r.currentItemCount,
              r.totalItems ?? 0,
              r.totalPages ?? 1));
        });
      }
    });
    on<OnOrgaUserEnable>((event, emit) async {
      emit(OrgaUserLoading());

      final result = await _enableOrgaUser.execute(
          event.orgaId, event.userId, event.enabled);
      result.fold((l) => emit(OrgaUserError(l.message)),
          (r) => {emit(const OrgaUserStart(""))});
    });
    on<OnOrgaUserDelete>((event, emit) async {
      emit(OrgaUserLoading());

      bool isDeleted = false;

      final result = await _deleteOrgaUser.execute(event.orgaId, event.userId);
      result.fold(
          (l) => emit(OrgaUserError(l.message)), (r) => {isDeleted = r});

      if (isDeleted) {
        emit(OrgaUserStart(
            " El Usuario ${event.user} fue desasociado de la organización"));
      }
    });
    on<OnOrgaUserListUserNotInOrgaForAdd>((event, emit) async {
      emit(OrgaUserLoading());

      final result = await _getUsersNotInOrga.execute(event.searchText,
          event.orgaId, event.fieldsOrder, event.pageIndex, event.pageSize);

      result.fold((l) => emit(OrgaUserError(l.message)), (r) {
        emit(OrgaUserListUserNotInOrgaLoaded(
            event.orgaId,
            r.items,
            event.searchText,
            event.fieldsOrder,
            event.pageIndex,
            event.pageSize,
            r.currentItemCount,
            r.totalItems ?? 0,
            r.totalPages ?? 1));
      });
    });
    on<OnOrgaUserStarter>(
        ((event, emit) async => emit(const OrgaUserStart(""))));
  }
}
