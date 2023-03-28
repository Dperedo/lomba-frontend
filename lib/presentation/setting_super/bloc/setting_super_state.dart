import 'package:equatable/equatable.dart';
import 'package:lomba_frontend/domain/entities/orga.dart';
import 'package:lomba_frontend/domain/entities/role.dart';
import 'package:lomba_frontend/domain/entities/workflow/flow.dart';



abstract class SettingSuperState extends Equatable {
  const SettingSuperState();

  @override
  List<Object> get props => [];
}

class SettingSuperStart extends SettingSuperState {
  final String message;

  const SettingSuperStart(this.message);

  @override
  List<Object> get props => [message];
}

class SettingSuperLoading extends SettingSuperState {}

class SettingSuperLoaded extends SettingSuperState {
  final String orgaId;
  final String flowId;
  final String roleName;
  final String orgaIdForAnonymous;
  final List<Orga> listOrgas;
  final List<Flow> listFlows;
  final List<Role> listRoles;

  const SettingSuperLoaded(
    this.orgaId,
    this.flowId,
    this.roleName,
    this.orgaIdForAnonymous,
    this.listOrgas,
    this.listFlows,
    this.listRoles,
    );

  @override
  List<Object> get props => [
      orgaId,
      flowId,
      roleName,
      orgaIdForAnonymous,
      listOrgas,
      listFlows,
      listRoles,
    ];
}


class SettingSuperError extends SettingSuperState {
  final String message;

  const SettingSuperError(this.message);

  @override
  List<Object> get props => [message];
}
