import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/add_orgauser.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/delete_orgauser.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/enable_orgauser.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/get_orgausers.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/update_orgauser.dart';
import 'package:rxdart/rxdart.dart';

import '../../../users/domain/entities/user.dart';
import '../../../users/domain/usecases/get_users.dart';
import '../../domain/entities/orgauser.dart';
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

  OrgaUserBloc(this._addOrgaUser, this._deleteOrgaUser, this._enableOrgaUser,
      this._getOrgaUsers, this._updateOrgaUser, this._getUsers)
      : super(OrgaUserStart()) {
    on<OnOrgaUserListLoad>((event, emit) async {
      emit(OrgaUserLoading());
      final result = await _getUsers.execute(event.id, '', '', 1, 10);

      final resultOU = await _getOrgaUsers.execute(event.id);

      List<User> listUsers = [];
      result.fold(
          (l) => emit(OrgaUserError(l.message)), (r) => {listUsers = r});

      List<OrgaUser> listOrgaUsers = [];
      resultOU.fold(
          (l) => emit(OrgaUserError(l.message)), (r) => {listOrgaUsers = r});

      emit(OrgaUserListLoaded(event.id, listUsers, listOrgaUsers));
    });
    on<OnOrgaUserAdd>((event, emit) async {
      emit(OrgaUserLoading());

      final result = await _addOrgaUser.execute(
          event.orgaId, event.userId, event.roles, event.enabled);

      result.fold((l) => emit(OrgaUserError(l.message)),
          (r) => {emit(OrgaUserStart())});
    });
    on<OnOrgaUserEdit>((event, emit) async {
      emit(OrgaUserLoading());

      final orgaUser = OrgaUser(
          orgaId: event.orgaId,
          userId: event.userId,
          roles: event.roles,
          enabled: event.enabled,
          builtIn: false);

      final result =
          await _updateOrgaUser.execute(event.orgaId, event.userId, orgaUser);
      result.fold((l) => emit(OrgaUserError(l.message)),
          (r) => {emit(OrgaUserStart())});
    });
    on<OnOrgaUserEnable>((event, emit) async {
      emit(OrgaUserLoading());

      final result = await _enableOrgaUser.execute(
          event.orgaId, event.userId, event.enabled);
      result.fold((l) => emit(OrgaUserError(l.message)),
          (r) => {emit(OrgaUserStart())});
    });
    on<OnOrgaUserDelete>((event, emit) async {
      emit(OrgaUserLoading());

      final result = await _deleteOrgaUser.execute(event.orgaId, event.userId);
      result.fold((l) => emit(OrgaUserError(l.message)),
          (r) => {emit(OrgaUserStart())});
    });
    on<OnOrgaUserPrepareForEdit>((event, emit) async {
      emit(OrgaUserLoading());

      final orgaUserResult = await _getOrgaUsers.execute(event.orgaId);

      List<OrgaUser> listOrgaUsers = [];

      orgaUserResult.fold(
          (l) => {emit(OrgaUserError(l.message))},
          (r) => listOrgaUsers =
              r.where((element) => element.userId == event.userId).toList());

      if (listOrgaUsers.isNotEmpty) {
        emit(OrgaUserEditing(listOrgaUsers[0]));
      }
    });
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
