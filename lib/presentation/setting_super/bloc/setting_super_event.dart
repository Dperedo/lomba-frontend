import 'package:equatable/equatable.dart';

abstract class SettingSuperEvent extends Equatable {
  const SettingSuperEvent();

  @override
  List<Object?> get props => [];
}

class OnSettingSuperLoad extends SettingSuperEvent {
  const OnSettingSuperLoad();

  @override
  List<Object> get props => [];
}

class OnSettingSuperSave extends SettingSuperEvent {
  final String orgaId;
  final String flowId;
  final String roleName;
  final String orgaIdAnony;
  const OnSettingSuperSave(this.orgaId, this.flowId, this.roleName, this.orgaIdAnony);

  @override
  List<Object> get props => [orgaId, flowId, roleName, orgaIdAnony];
}

class OnSettingSuperEdit extends SettingSuperEvent {
  final String orgaId;
  final String flowId;
  final String roleName;
  final String orgaIdAnony;
  const OnSettingSuperEdit(this.orgaId, this.flowId, this.roleName, this.orgaIdAnony);

  @override
  List<Object> get props => [orgaId, flowId, roleName, orgaIdAnony];
}

class OnSettingSuperStarter extends SettingSuperEvent {}
