import 'package:equatable/equatable.dart';

abstract class SettingAdminEvent extends Equatable {
  const SettingAdminEvent();

  @override
  List<Object?> get props => [];
}

class OnSettingAdminLoad extends SettingAdminEvent {
  const OnSettingAdminLoad();

  @override
  List<Object> get props => [];
}

class OnSettingAdminSave extends SettingAdminEvent {
  final String orgaId;
  final String flowId;
  final String roleName;
  const OnSettingAdminSave(this.orgaId,this.flowId, this.roleName);

  @override
  List<Object> get props => [orgaId, flowId, roleName];
}

class OnSettingAdminEdit extends SettingAdminEvent {
  final String orgaId;
  final String flowId;
  final String roleName;
  const OnSettingAdminEdit(this.orgaId, this.flowId, this.roleName);

  @override
  List<Object> get props => [orgaId, flowId, roleName];
}

class OnSettingAdminStarter extends SettingAdminEvent {}
