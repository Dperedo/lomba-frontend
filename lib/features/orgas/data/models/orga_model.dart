import '../../domain/entities/orga.dart';

class OrgaModel extends Orga {
  const OrgaModel(
      {required id,
      required name,
      required code,
      required enabled,
      required builtIn})
      : super(
            id: id, name: name, code: code, enabled: enabled, builtIn: builtIn);

  factory OrgaModel.fromJson(Map<String, dynamic> json) {
    return OrgaModel(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        enabled: json["enabled"],
        builtIn: json["builtIn"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'enabled': enabled,
      'builtIn': builtIn
    };
  }

  Orga toEntity() =>
      Orga(id: id, name: name, code: code, enabled: enabled, builtIn: builtIn);

  @override
  List<Object> get props => [id, name, code, enabled, builtIn];
}
