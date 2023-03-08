import 'package:equatable/equatable.dart';
import '../../../domain/entities/workflow/flow.dart';

///Interfaz de flows para el Bloc
abstract class FlowState extends Equatable {
  const FlowState();

  @override
  List<Object> get props => [];
}

///Estado inicial de la página de flows.
class FlowStart extends FlowState {}

///Estado es para un proceso corriendo, así mostramos el spinner de carga
class FlowLoading extends FlowState {}

///Estado de un flow ya conseguido, obtenido en [flow]
class FlowLoaded extends FlowState {
  final Flow flow;
  const FlowLoaded(this.flow);
  @override
  List<Object> get props => [flow];
}

///Estado para la lista de flows ya cargada.
class FlowListLoaded extends FlowState {
  final List<Flow> flows;
  const FlowListLoaded(this.flows);
  @override
  List<Object> get props => [flows];
}

class FlowEnabling extends FlowState {}

class FlowError extends FlowState {
  final String message;

  const FlowError(this.message);

  @override
  List<Object> get props => [message];
}
