import 'package:equatable/equatable.dart';
import 'package:lomba_frontend/core/validators.dart';

import '../../domain/entities/orga.dart';

///Interfaz de los estados del bloc de organizaciones
abstract class OrgaState extends Equatable {
  const OrgaState();

  @override
  List<Object> get props => [];
}

///Estado inicial de la página
class OrgaStart extends OrgaState {}

///Estado de trabajo mientras la información o proceso es ejecutado.
class OrgaLoading extends OrgaState {}

///Estado de organización ya conseguida desde el origen
class OrgaLoaded extends OrgaState {
  final Orga orga;
  const OrgaLoaded(this.orga);
  @override
  List<Object> get props => [orga];
}

///Estado para la lista de organizaciones ya cargada
class OrgaListLoaded extends OrgaState {
  final List<Orga> orgas;
  const OrgaListLoaded(this.orgas);
  @override
  List<Object> get props => [orgas];
}

///Estado para mostrar la pantalla con campos para agregar la organización
class OrgaAdding extends OrgaState {
  bool existOrgaName = false;
  bool existCode = false;
  OrgaAdding(bool existorganame, bool existcode){
    existOrgaName = existorganame;
    existCode = existcode;
  }
  OrgaAdding copyWith(bool existorganame, bool existcode){
    existOrgaName = existorganame;
    existCode = existcode;
    return this;
  }
  String? validateOrgaName(String orgaName){
    String? res = Validators.validateUsername(orgaName);
    if(res == null){
      if (existOrgaName) {
        return "El organame ya existe";
      }
    }
    else {
      return res;
    }
    return null;

  }
  String? validateCode(String code) {
    String? res = Validators.validateCode(code);

    if (res == null) {
      if (existCode) {
        return "El codigo ya existe";
      }
    } else {
      return res;
    }

    return null;
  }
  @override
  List<Object> get props => [existOrgaName, existCode];
}

///Estado para mostrar la pantalla con campos con datos y editar organización
class OrgaEditing extends OrgaState {
  final Orga orga;
  const OrgaEditing(this.orga);
  @override
  List<Object> get props => [orga];
}

///Estado para mostrar opciones de habilitar o deshabilitar organización
class OrgaEnabling extends OrgaState {}

///Estado para mostrar opciones de eliminación de organizaciones
class OrgaDeleting extends OrgaState {}

///Estado para indicar errores en alguno de los procesos o eventos.
class OrgaError extends OrgaState {
  final String message;

  const OrgaError(this.message);

  @override
  List<Object> get props => [message];
}
