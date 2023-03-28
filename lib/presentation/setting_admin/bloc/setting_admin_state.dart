import 'package:equatable/equatable.dart';
import 'package:lomba_frontend/domain/entities/role.dart';
import 'package:lomba_frontend/domain/entities/workflow/flow.dart';



abstract class SettingAdminState extends Equatable {
  const SettingAdminState();

  @override
  List<Object> get props => [];
}

class SettingAdminStart extends SettingAdminState {
  final String message;

  const SettingAdminStart(this.message);

  @override
  List<Object> get props => [message];
}

class SettingAdminLoading extends SettingAdminState {}

class SettingAdminLoaded extends SettingAdminState {
  final String orgaId;
  final String flowId;
  final String roleName;
  final List<Flow> listFlows;
  final List<Role> listRoles;

  const SettingAdminLoaded(
    this.orgaId,
    this.flowId,
    this.roleName,
    this.listFlows,
    this.listRoles,
    );

  @override
  List<Object> get props => [
      orgaId,
      flowId,
      roleName,
      listFlows,
      listRoles,
    ];
}


class SettingAdminError extends SettingAdminState {
  final String message;

  const SettingAdminError(this.message);

  @override
  List<Object> get props => [message];
}
