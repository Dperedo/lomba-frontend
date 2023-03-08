import 'package:equatable/equatable.dart';

///Interfaz de todos los eventos del Stage
abstract class StageEvent extends Equatable {
  const StageEvent();
}

///Evento para llamar y traer el stage asignado al [name]
class OnStageLoad extends StageEvent {
  final String name;

  const OnStageLoad(this.name);

  @override
  List<Object> get props => [name];
}

///Evento para traer la lista de stages
class OnStageListLoad extends StageEvent {

  const OnStageListLoad();

  @override
  List<Object> get props => [];
}

/*class OnStageEnable extends StageEvent {
  final String name;

  final bool enabled;

  const OnStageEnable(this.name, this.enabled);

  @override
  List<Object> get props => [name, enabled];
}*/
