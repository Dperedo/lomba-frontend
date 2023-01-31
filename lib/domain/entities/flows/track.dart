import 'package:equatable/equatable.dart';

class Track extends Equatable {
  const Track({
    required this.userId,
    required this.flowId,
    required this.stageId,
    required this.change,
    required this.created,
    required this.updated,
    required this.deleted,
    required this.expires,});

    final String flowId;
    final String stageId;
    final String userId;
    final String change;
    final DateTime created;
    final DateTime? updated;
    final DateTime? deleted;
    final DateTime? expires;
  @override
  
  List<Object?> get props => [
    userId,change,flowId,stageId,created
  ];
}