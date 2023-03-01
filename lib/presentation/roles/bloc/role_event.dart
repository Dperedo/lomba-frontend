import 'package:equatable/equatable.dart';

///Interfaz de todos los eventos del Role
abstract class RoleEvent extends Equatable {
  const RoleEvent();
}

///Evento para llamar y traer el role asignado al [name]
class OnRoleLoad extends RoleEvent {
  final String name;

  const OnRoleLoad(this.name);

  @override
  List<Object> get props => [name];
}

///Evento para traer la lista de roles
class OnRoleListLoad extends RoleEvent {

  const OnRoleListLoad();

  @override
  List<Object> get props => [];
}

class OnRoleEnable extends RoleEvent {
  final String name;

  final bool enabled;

  const OnRoleEnable(this.name, this.enabled);

  @override
  List<Object> get props => [name, enabled];
}
