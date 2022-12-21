import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/add_orgauser.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/delete_orgauser.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/enable_orgauser.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/get_orgausers.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/update_orgauser.dart';
import 'package:rxdart/rxdart.dart';

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

  OrgaUserBloc(this._addOrgaUser, this._deleteOrgaUser, this._enableOrgaUser,
      this._getOrgaUsers, this._updateOrgaUser)
      : super(OrgaUserStart()) {
    on<OnOrgaUserListLoad>((event, emit) async {
      emit(OrgaUserLoading());
      final result = await _getOrgaUsers.execute(event.id);

      result.fold((l) => emit(OrgaUserError(l.message)),
          (r) => {emit(OrgaUserListLoaded(r))});
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
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
