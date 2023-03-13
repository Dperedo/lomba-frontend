import 'package:equatable/equatable.dart';

///Interfaz de todos los eventos del Flow
abstract class FlowEvent extends Equatable {
  const FlowEvent();
}

///Evento para llamar y traer el flow asignado al [id]
class OnFlowLoad extends FlowEvent {
  final String id;

  const OnFlowLoad(this.id);

  @override
  List<Object> get props => [id];
}

///Evento para traer la lista de flows
class OnFlowListLoad extends FlowEvent {

  const OnFlowListLoad();

  @override
  List<Object> get props => [];
}

class OnFlowListStarter extends FlowEvent {
  const OnFlowListStarter();
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
