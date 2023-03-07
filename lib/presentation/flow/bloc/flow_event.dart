import 'package:equatable/equatable.dart';

///Interfaz de todos los eventos del Flow
abstract class FlowEvent extends Equatable {
  const FlowEvent();
}

///Evento para llamar y traer el flow asignado al [name]
class OnFlowLoad extends FlowEvent {
  final String name;

  const OnFlowLoad(this.name);

  @override
  List<Object> get props => [name];
}

///Evento para traer la lista de flows
class OnFlowListLoad extends FlowEvent {

  const OnFlowListLoad();

  @override
  List<Object> get props => [];
}

/*class OnFlowEnable extends FlowEvent {
  final String name;

  final bool enabled;

  const OnFlowEnable(this.name, this.enabled);

  @override
  List<Object> get props => [name, enabled];
}*/
