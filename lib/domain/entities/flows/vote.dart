import 'package:equatable/equatable.dart';

class Vote extends Equatable {
  const Vote({
    required this.totalpositive,
    required this.totalnegative,
    required this.totalcount,
    required this.flowId,
    required this.stageId,
    required this.userId,
    required this.number,
    required this.created,
    required this.updated,
    required this.deleted,
    required this.expires,});

    final int totalpositive;
    final int totalnegative;
    final int totalcount;
    final String flowId;
    final String stageId;
    final int number;
    final String userId;
    final DateTime created;
    final DateTime? updated;
    final DateTime? deleted;
    final DateTime? expires;

  @override
  
  List<Object?> get props => [
    totalpositive,totalnegative,totalcount,flowId,stageId,number,userId,created
  ];
}