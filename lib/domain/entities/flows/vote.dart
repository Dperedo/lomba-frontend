import 'package:equatable/equatable.dart';

class Vote extends Equatable {
  const Vote({
    
    required this.flowId,
    required this.stageId,
    required this.userId,
    required this.value,
    required this.created,
    required this.updated,
    required this.deleted,
    required this.expires,});

    
    final String flowId;
    final String stageId;
    final int value;
    final String userId;
    final DateTime created;
    final DateTime? updated;
    final DateTime? deleted;
    final DateTime? expires;

  @override
  
  List<Object?> get props => [
    flowId,stageId,value,userId,created
  ];
}