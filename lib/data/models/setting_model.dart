import '../../domain/entities/setting.dart';

class SettingModel extends Setting {
  const SettingModel({
    required id,
    required code,
    required value,
    required builtIn,
    required orgaId,
    required created,
    required updated
    })
      : super(
        id: id,
        code: code,
        value: value,
        builtIn: builtIn,
        orgaId: orgaId,
        created: created,
        updated: updated
        );

  factory SettingModel.fromJson(Map<String, dynamic> json) {
    return SettingModel(
      id: json["id"],
      code: json["code"],
      value: json["value"],
      builtIn: json["builtIn"],
      orgaId: json["orgaId"],
      created: json["created"],
      updated: json["updated"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'value': value,
      'builtIn': builtIn,
      'orgaId': orgaId,
      'created': created,
      'updated': updated,
    };
  }

  Setting toEntity() => Setting(
        id: id,
        code: code,
        value: value,
        builtIn: builtIn,
        orgaId: orgaId,
        created: created,
        updated: updated,
      );

  @override
  List<Object> get props => [id, code, value, builtIn, created];
}
