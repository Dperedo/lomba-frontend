import 'package:lomba_frontend/domain/entities/workflow/stage.dart';

class StageModel extends Stage {
  const StageModel({
    required id,
    required name,
    required order,
    required queryOut,
    required enabled,
    required builtIn,
    required created,
    required updated,
    required deleted,
    required expires,})
    : super(
      id: id,
      name: name,
      order: order,
      queryOut: queryOut,
      enabled: enabled,
      builtIn: builtIn,
      created: created,
      updated: updated,
      deleted: deleted,
      expires: expires,
    );

  factory StageModel.fromJson(Map<String, dynamic> json){
    return StageModel(
      id: json['id'],
      name: json['name'],
      order: json['order'],
      queryOut: json['queryOut'],
      enabled: json['enabled'],
      builtIn: json['builtIn'],
      created: DateTime.parse(json['created'].toString()),
      updated: json['updated'] != null? DateTime.parse(json['updated'].toString()): null,
      deleted: json['deleted'] != null? DateTime.parse(json['deleted'].toString()): null,
      expires: json['expires'] != null? DateTime.parse(json['expires'].toString()): null
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'name': name,
      'order': order,
      'queryOut': queryOut,
      'enabled': enabled,
      'builtIn': builtIn,
      'created': created,
      'updated': updated,
      'deleted': deleted,
      'expires': expires
    };
  }

  Stage toEntity() => Stage(
      id: id,
      name: name,
      order: order,
      queryOut: queryOut,
      enabled: enabled,
      builtIn: builtIn,
      created: created,
      updated: updated,
      deleted: deleted,
      expires: expires
  );

  @override
  List<Object?> get props => [
    id, name, order, queryOut, enabled, builtIn, created
  ];
}