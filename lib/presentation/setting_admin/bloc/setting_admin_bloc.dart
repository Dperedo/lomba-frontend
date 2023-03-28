import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/entities/orga.dart';
import 'package:lomba_frontend/domain/entities/session.dart';
import 'package:lomba_frontend/domain/usecases/flow/get_flows.dart';
import 'package:lomba_frontend/domain/usecases/local/get_session_status.dart';
import 'package:lomba_frontend/domain/usecases/orgas/get_orgas.dart';
import 'package:lomba_frontend/domain/usecases/roles/get_roles.dart';
import 'package:lomba_frontend/presentation/setting_admin/bloc/setting_admin_event.dart';
import 'package:lomba_frontend/presentation/setting_admin/bloc/setting_admin_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/constants.dart';
import '../../../data/models/session_model.dart';
import '../../../domain/entities/role.dart';
import '../../../domain/entities/workflow/flow.dart';
import '../../../domain/usecases/setting/get_setting_admin.dart';
import '../../../domain/usecases/setting/updated_setting_admin.dart';

class SettingAdminBloc extends Bloc<SettingAdminEvent, SettingAdminState> {
  final GetSession _getSession;
  final GetSettingAdmin _getSettingAdmin;
  final GetOrgas _getOrgas;
  final GetFlows _getFlows;
  final GetRoles _getRoles;
  final UpdatedSettingAdmin _updatedSettingAdmin;

  SettingAdminBloc(
    this._getSession,
    this._getSettingAdmin,
    this._getOrgas,
    this._getFlows,
    this._getRoles,
    this._updatedSettingAdmin,
    ) : super(const SettingAdminStart('')) {
    on<OnSettingAdminStarter>((event, emit) => emit(const SettingAdminStart('')));

    on<OnSettingAdminLoad>(
      (event, emit) async {
        emit(SettingAdminLoading());

        var flowId = '';
        var roleName = '';

        var auth = const SessionModel(token: "", username: "", name: "");
        final session = await _getSession.execute();
        session.fold((l) => emit(SettingAdminError(l.message)), (r) => {auth = r});
        final orgaId = auth.getOrgaId();

        final resultSetting = await _getSettingAdmin.execute(orgaId!);
        resultSetting.fold((l) => emit(SettingAdminError(l.message)),
        (r) {
          flowId = r.firstWhere((e) => e.code == SettingCodes.defaultFlow).value;
          roleName = r.firstWhere((e) => e.code == SettingCodes.defaultRoleForUserRegister).value;
        });

        List<Flow> listFlows = [];
        final resultFlows = await _getFlows.execute();
        resultFlows.fold((l) => emit(SettingAdminError(l.message)),
        (r) => listFlows = r);

        List<Role> listRoles = [];
        final resultRoles = await _getRoles.execute();
        resultRoles.fold((l) => emit(SettingAdminError(l.message)),
        (r) => listRoles = r);

        emit(SettingAdminLoaded(orgaId,flowId,roleName,listFlows,listRoles));

      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    on<OnSettingAdminEdit>(
      (event, emit) async {
        emit(SettingAdminLoading());

        var settingId = '';
        final resultSetting = await _getSettingAdmin.execute(event.orgaId);
        resultSetting.fold((l) => emit(SettingAdminError(l.message)),
        (r) {
          settingId = r.firstWhere((e) => e.code == event.code).id;
        });

        final resultUpdate = await _updatedSettingAdmin.execute(settingId, event.id, event.orgaId);
        resultUpdate.fold((l) => emit(SettingAdminError(l.message)), 
        (r) => emit(const SettingAdminStart('')));

      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );
    
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
