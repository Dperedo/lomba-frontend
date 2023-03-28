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

class OnSettingAdminEdit extends SettingAdminEvent {
  final String id;
  final String code;
  final String orgaId;
  const OnSettingAdminEdit(this.id, this.code, this.orgaId);

  @override
  List<Object> get props => [id, code, orgaId];
}

class OnSettingAdminStarter extends SettingAdminEvent {}
