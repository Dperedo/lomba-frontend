import 'package:equatable/equatable.dart';

import '../../../domain/entities/workflow/stage.dart';

///Interfaz de stages para el Bloc
abstract class StageState extends Equatable {
  const StageState();

  @override
  List<Object> get props => [];
}

///Estado inicial de la página de stages.
class StageStart extends StageState {}

///Estado es para un proceso corriendo, así mostramos el spinner de carga
class StageLoading extends StageState {}

///Estado de un stage ya conseguido, obtenido en [stage]
class StageLoaded extends StageState {
  final Stage stage;
  const StageLoaded(this.stage);
  @override
  List<Object> get props => [stage];
}

///Estado para la lista de stages ya cargada.
class StageListLoaded extends StageState {
  final List<Stage> stages;
  const StageListLoaded(this.stages);
  @override
  List<Object> get props => [stages];
}

class StageEnabling extends StageState {}

class StageError extends StageState {
  final String message;

  const StageError(this.message);

  @override
  List<Object> get props => [message];
}
