import 'package:equatable/equatable.dart';

import '../../domain/entities/role.dart';

///Interfaz de roles para el Bloc
abstract class RoleState extends Equatable {
  const RoleState();

  @override
  List<Object> get props => [];
}

///Estado inicial de la página de roles.
class RoleStart extends RoleState {}

///Estado es para un proceso corriendo, así mostramos el spinner de carga
class RoleLoading extends RoleState {}

///Estado de un role ya conseguido, obtenido en [role]
class RoleLoaded extends RoleState {
  final Role role;
  const RoleLoaded(this.role);
  @override
  List<Object> get props => [role];
}

///Estado para la lista de roles ya cargada.
class RoleListLoaded extends RoleState {
  final List<Role> roles;
  const RoleListLoaded(this.roles);
  @override
  List<Object> get props => [roles];
}

///Estado para cuando mostremos opciones de habilitar y deshabilitar
class RoleEnabling extends RoleState {}

///Estado para mostrar un problema en alguno de los procesos.
class RoleError extends RoleState {
  final String message;

  const RoleError(this.message);

  @override
  List<Object> get props => [message];
}
