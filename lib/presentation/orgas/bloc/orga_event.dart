import 'package:equatable/equatable.dart';

import '../../../domain/entities/orga.dart';
import 'orga_state.dart';

///Interfaz del evento de organizaciones
abstract class OrgaEvent extends Equatable {
  const OrgaEvent();

  @override
  List<Object?> get props => [];
}

///Evento que se dispara para conseguir una organización
class OnOrgaLoad extends OrgaEvent {
  final String id;

  const OnOrgaLoad(this.id);

  @override
  List<Object> get props => [id];
}

///Evento se dispara para obtener la lista de organizaciones filtrada y paginada
class OnOrgaListLoad extends OrgaEvent {
  final String filter;
  final String fieldOrder;
  final double pageNumber;

  const OnOrgaListLoad(this.filter, this.fieldOrder, this.pageNumber);

  @override
  List<Object> get props => [filter, fieldOrder, pageNumber];
}

///Evento se dispara para agregar una nueva organización
class OnOrgaAdd extends OrgaEvent {
  final String name;
  final String code;
  final bool enabled;

  const OnOrgaAdd(this.name, this.code, this.enabled);

  @override
  List<Object> get props => [name, code, enabled];
}

class OnOrgaValidate extends OrgaEvent {
  final String orgaName;
  final String code;
  final OrgaAdding state;

  const OnOrgaValidate(this.orgaName, this.code, this.state);

  @override
  List<Object> get props => [orgaName, code];
}

class OnOrgaPrepareForAdd extends OrgaEvent {
  @override
  List<Object> get props => [];
}

///Evento se dispara para actualizar (persistir) cambios en la organización
class OnOrgaEdit extends OrgaEvent {
  final String id;
  final String name;
  final String code;
  final bool enabled;

  const OnOrgaEdit(this.id, this.name, this.code, this.enabled);

  @override
  List<Object> get props => [id, name, code, enabled];
}

///Evento se dispara para habilitar o deshabilitar una organización
class OnOrgaEnable extends OrgaEvent {
  final String id;

  final bool enabled;

  const OnOrgaEnable(this.id, this.enabled);

  @override
  List<Object> get props => [id, enabled];
}

///Evento se dispara para eliminar una organización
class OnOrgaDelete extends OrgaEvent {
  final String id;

  const OnOrgaDelete(this.id);

  @override
  List<Object> get props => [id];
}

class OnOrgaShowAddOrgaForm extends OrgaEvent {}

class OnOrgaSaveNewOrga extends OrgaEvent {
  final String organame;
  final String code;

  const OnOrgaSaveNewOrga(this.organame, this.code);

  @override
  List<Object> get props => [organame, code];
}

class OnOrgaPrepareForEdit extends OrgaEvent {
  final Orga orga;

  const OnOrgaPrepareForEdit(this.orga);

  @override
  List<Object> get props => [orga];
}

class OnOrgaValidateEdit extends OrgaEvent {
  final String code;
  final OrgaEditing state;

  const OnOrgaValidateEdit(this.code, this.state);

  @override
  List<Object> get props => [code, state];
}
