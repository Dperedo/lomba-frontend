import '../../../domain/entities/workflow/flow.dart';

class FlowModel extends Flow {
  const FlowModel({
    required id,
    required name,
    required stages,
    required enabled,
    required builtIn,
    required created,
    required updated,
    required deleted,
    required expires,})
    : super(
      id: id,
      name: name,
      stages: stages,
      enabled: enabled,
      builtIn: builtIn,
      created: created,
      updated: updated,
      deleted: deleted,
      expires: expires,
    );

  factory FlowModel.fromJson(Map<String, dynamic> json){
    return FlowModel(
      id: json['id'],
      name: json['name'],
      enabled: json['enabled'],
      builtIn: json['builtIn'],
      created: json['created'],
      stages: (json["stages"] as List<dynamic>).cast<String>(),
      updated: json['updated'],
      deleted: json['deleted'],
      expires: json['expires']
    );
  }

  Flow toEntity() => Flow(
      id: id,
      name: name,
      enabled: enabled,
      builtIn: builtIn,
      created: created,
      stages: stages,
      updated: updated,
      deleted: deleted,
      expires: expires
  );

  @override
  List<Object?> get props => [
    id, name, enabled, builtIn, created, stages
  ];
}