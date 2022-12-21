import '../../domain/entities/orga.dart';

///El [OrgaModel] representa la información de una organización en el sistema
///
///Extiende de [Orga] sus atributos.
class OrgaModel extends Orga {
  const OrgaModel(
      {required id,
      required name,
      required code,
      required enabled,
      required builtIn})
      : super(
            id: id, name: name, code: code, enabled: enabled, builtIn: builtIn);

  ///Crea un [OrgaModel] desde un Map (json)
  factory OrgaModel.fromJson(Map<String, dynamic> json) {
    return OrgaModel(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        enabled: json["enabled"],
        builtIn: json["builtIn"]);
  }

  ///Entrega un Map (json) desde el mismo objeto actual
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'enabled': enabled,
      'builtIn': builtIn
    };
  }

  ///Entrega la entidad [Orga] desde el objeto actual.
  Orga toEntity() =>
      Orga(id: id, name: name, code: code, enabled: enabled, builtIn: builtIn);

  ///Propiedades para la comparación de objetos con Equalable
  @override
  List<Object> get props => [id, name, code, enabled, builtIn];
}
