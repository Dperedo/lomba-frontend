import '../../domain/entities/role.dart';

class RoleModel extends Role {
  const RoleModel({required name, required enabled})
      : super(name: name, enabled: enabled);

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      name: json["name"],
      enabled: json["enabled"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'enabled': enabled,
    };
  }

  Role toEntity() => Role(
        name: name,
        enabled: enabled,
      );

  @override
  List<Object> get props => [name, enabled];
}
