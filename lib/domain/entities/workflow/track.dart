import 'package:equatable/equatable.dart';

class Track extends Equatable {
  const Track({
    required this.name,
    required this.description,
    required this.userId,
    required this.flowId,
    required this.stageIdOld,
    required this.stageIdNew,
    required this.change,
    required this.created,
    required this.updated,
    required this.deleted,
    required this.expires,});

    final String name;
    final String description;
    final String flowId;
    final String stageIdOld;
    final String stageIdNew;
    final String userId;
    final String change;
    final DateTime created;
    final DateTime? updated;
    final DateTime? deleted;
    final DateTime? expires;
  @override
  
  List<Object?> get props => [
    name,description,userId,change,flowId,stageIdOld,stageIdNew,created
  ];
}