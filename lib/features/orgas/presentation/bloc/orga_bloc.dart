import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/add_orga.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/add_orgauser.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/delete_orga.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/delete_orgauser.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/enable_orga.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/enable_orgauser.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/get_orga.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/get_orgausers.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/update_orga.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/update_orgauser.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/orga.dart';
import '../../domain/entities/orgauser.dart';
import '../../domain/usecases/get_orgas.dart';
import 'orga_event.dart';
import 'orga_state.dart';

class OrgaBloc extends Bloc<OrgaEvent, OrgaState> {
  final AddOrga _addOrga;
  final AddOrgaUser _addOrgaUser;
  final DeleteOrga _deleteOrga;
  final DeleteOrgaUser _deleteOrgaUser;
  final EnableOrga _enableOrga;
  final EnableOrgaUser _enableOrgaUser;
  final GetOrga _getOrga;
  final GetOrgas _getOrgas;
  final GetOrgaUsers _getOrgaUsers;
  final UpdateOrga _updateOrga;
  final UpdateOrgaUser _updateOrgaUser;

  OrgaBloc(
      this._addOrga,
      this._addOrgaUser,
      this._deleteOrga,
      this._deleteOrgaUser,
      this._enableOrga,
      this._enableOrgaUser,
      this._getOrga,
      this._getOrgas,
      this._getOrgaUsers,
      this._updateOrga,
      this._updateOrgaUser)
      : super(OrgaStart()) {
    on<OnOrgaLoad>(
      (event, emit) async {
        emit(OrgaLoading());
        final result = await _getOrga.execute(event.id);

        result.fold(
            (l) => emit(OrgaError(l.message)), (r) => {emit(OrgaLoaded(r))});
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    on<OnOrgaListLoad>(
      (event, emit) async {
        emit(OrgaLoading());
        final result = await _getOrgas.execute(
            event.filter, event.fieldOrder, event.pageNumber, 10);

        result.fold((l) => emit(OrgaError(l.message)),
            (r) => {emit(OrgaListLoaded(r))});
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    on<OnOrgaAdd>((event, emit) async {
      emit(OrgaLoading());

      final orga = Orga(
          id: Guid.newGuid.toString(),
          name: event.name,
          code: event.code,
          enabled: event.enabled,
          builtIn: false);

//TODO: el llamado debe ser con los parámetros uno por uno.
//debido al id autogenerado del ejemplo
      final result = await _addOrga.execute(orga);

      result.fold((l) => emit(OrgaError(l.message)), (r) => {OrgaStart()});
    });
    on<OnOrgaEdit>((event, emit) async {
      emit(OrgaLoading());

      final orga = Orga(
          id: event.id,
          name: event.name,
          code: event.code,
          enabled: event.enabled,
          builtIn: false);

      final result = await _updateOrga.execute(event.id, orga);
      result.fold((l) => emit(OrgaError(l.message)), (r) => {OrgaStart()});
    });
    on<OnOrgaEnable>((event, emit) async {
      emit(OrgaLoading());

      final result = await _enableOrga.execute(event.id, event.enabled);
      result.fold((l) => emit(OrgaError(l.message)), (r) => {OrgaStart()});
    });
    on<OnOrgaDelete>((event, emit) async {
      emit(OrgaLoading());

      final result = await _deleteOrga.execute(event.id);
      result.fold((l) => emit(OrgaError(l.message)), (r) => {OrgaStart()});
    });
    on<OnOrgaUserListLoad>((event, emit) async {
      emit(OrgaLoading());
      final result = await _getOrgaUsers.execute(event.id);

      result.fold((l) => emit(OrgaError(l.message)),
          (r) => {emit(OrgaUserListLoaded(r))});
    });
    on<OnOrgaUserAdd>((event, emit) async {
      emit(OrgaLoading());

      final orgaUser = OrgaUser(
          orgaId: event.orgaId,
          userId: event.userId,
          roles: event.roles,
          enabled: event.enabled,
          builtIn: false);

      final result = await _addOrgaUser.execute(orgaUser);

      result.fold((l) => emit(OrgaError(l.message)), (r) => {OrgaStart()});
    });
    on<OnOrgaUserEdit>((event, emit) async {
      emit(OrgaLoading());

      final orgaUser = OrgaUser(
          orgaId: event.orgaId,
          userId: event.userId,
          roles: event.roles,
          enabled: event.enabled,
          builtIn: false);

      final result =
          await _updateOrgaUser.execute(event.orgaId, event.userId, orgaUser);
      result.fold((l) => emit(OrgaError(l.message)), (r) => {OrgaStart()});
    });
    on<OnOrgaUserEnable>((event, emit) async {
      emit(OrgaLoading());

      final result = await _enableOrgaUser.execute(
          event.orgaId, event.userId, event.enabled);
      result.fold((l) => emit(OrgaError(l.message)), (r) => {OrgaStart()});
    });
    on<OnOrgaUserDelete>((event, emit) async {
      emit(OrgaLoading());

      final result = await _deleteOrgaUser.execute(event.orgaId, event.userId);
      result.fold((l) => emit(OrgaError(l.message)), (r) => {OrgaStart()});
    });
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
