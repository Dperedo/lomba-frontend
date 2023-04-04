import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/entities/orga.dart';
import 'package:lomba_frontend/domain/usecases/flow/get_flows.dart';
import 'package:lomba_frontend/domain/usecases/orgas/get_orgas.dart';
import 'package:lomba_frontend/domain/usecases/roles/get_roles.dart';
import 'package:lomba_frontend/domain/usecases/setting/get_setting_super.dart';
import 'package:lomba_frontend/domain/usecases/setting/updated_setting_super.dart';
import 'package:lomba_frontend/presentation/setting_super/bloc/setting_super_event.dart';
import 'package:lomba_frontend/presentation/setting_super/bloc/setting_super_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/constants.dart';
import '../../../domain/entities/role.dart';
import '../../../domain/entities/workflow/flow.dart';

class SettingSuperBloc extends Bloc<SettingSuperEvent, SettingSuperState> {
  final GetSettingSuper _getSettingSuper;
  final GetOrgas _getOrgas;
  final GetFlows _getFlows;
  final GetRoles _getRoles;
  final UpdatedSettingSuper _updatedSettingSuper;

  SettingSuperBloc(
    this._getSettingSuper,
    this._getOrgas,
    this._getFlows,
    this._getRoles,
    this._updatedSettingSuper,
    ) : super(const SettingSuperStart('')) {
    on<OnSettingSuperStarter>((event, emit) => emit(const SettingSuperStart('')));

    on<OnSettingSuperLoad>(
      (event, emit) async {
        emit(SettingSuperLoading());

        var orgaId = '';
        var flowId = '';
        var roleName = '';
        var orgaIdForAnonymous = '';

        final resultSetting = await _getSettingSuper.execute();
        resultSetting.fold((l) => emit(SettingSuperError(l.message)),
        (r) {
          orgaId = r.firstWhere((e) => e.code == SettingCodes.defaultOrgaForUserRegister).value;
          flowId = r.firstWhere((e) => e.code == SettingCodes.defaultFlow).value;
          roleName = r.firstWhere((e) => e.code == SettingCodes.defaultRoleForUserRegister).value;
          orgaIdForAnonymous = r.firstWhere((e) => e.code == SettingCodes.orgaForAnonymousUser).value;
        });

        List<Orga> listOrgas = [];
        List<Orga> listOrgasAnony = [];
        final resultOrgas = await _getOrgas.execute('', '', 1, 50);
        resultOrgas.fold((l) => emit(SettingSuperError(l.message)),
        (r) {
          listOrgas = r;
          listOrgasAnony = r;
          }
        );

        List<Flow> listFlows = [];
        final resultFlows = await _getFlows.execute();
        resultFlows.fold((l) => emit(SettingSuperError(l.message)),
        (r) => listFlows = r);

        List<Role> listRoles = [];
        final resultRoles = await _getRoles.execute();
        resultRoles.fold((l) => emit(SettingSuperError(l.message)),
        (r) => listRoles = r);

        emit(SettingSuperLoaded(orgaId,flowId,roleName,orgaIdForAnonymous,listOrgas,listFlows,listRoles,listOrgasAnony));

      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    on<OnSettingSuperSave>(
      (event, emit) async {

        List<Orga> listOrgas = [];
        List<Orga> listOrgasAnony = [];
        final resultOrgas = await _getOrgas.execute('', '', 1, 50);
        resultOrgas.fold((l) => emit(SettingSuperError(l.message)),
        (r) {
          listOrgas = r;
          listOrgasAnony = r;
          }
        );

        List<Flow> listFlows = [];
        final resultFlows = await _getFlows.execute();
        resultFlows.fold((l) => emit(SettingSuperError(l.message)),
        (r) => listFlows = r);

        List<Role> listRoles = [];
        final resultRoles = await _getRoles.execute();
        resultRoles.fold((l) => emit(SettingSuperError(l.message)),
        (r) => listRoles = r);

        emit(SettingSuperLoaded(event.orgaId,event.flowId,event.roleName,event.orgaIdAnony,listOrgas,listFlows,listRoles,listOrgasAnony));

      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    on<OnSettingSuperEdit>(
      (event, emit) async {
        emit(SettingSuperLoading());

        var settingOrgaId = '';
        var settingFlowId = '';
        var settingRoleName = '';
        var settingOrgaIdAnony = '';
        final resultSetting = await _getSettingSuper.execute();
        resultSetting.fold((l) => emit(SettingSuperError(l.message)),
        (r) {
          settingOrgaId = r.firstWhere((e) => e.code == SettingCodes.defaultOrgaForUserRegister).id;
          settingFlowId = r.firstWhere((e) => e.code == SettingCodes.defaultFlow).id;
          settingRoleName = r.firstWhere((e) => e.code == SettingCodes.defaultRoleForUserRegister).id;
          settingOrgaIdAnony = r.firstWhere((e) => e.code == SettingCodes.orgaForAnonymousUser).id;
        });

        List<Map<String, dynamic>> settingList = [
          {
          'id': settingOrgaId,
          'value': event.orgaId,
          },
          {
          'id': settingFlowId,
          'value': event.flowId,
          },
          {
          'id': settingRoleName,
          'value': event.roleName,
          },
          {
          'id': settingOrgaIdAnony,
          'value': event.orgaIdAnony,
          },
        ];

        final resultUpdate = await _updatedSettingSuper.execute(settingList);
        resultUpdate.fold((l) => emit(SettingSuperError(l.message)), 
        (r) => emit(const SettingSuperStart('Se actualizaron los campos')));

      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );
    
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
