import 'package:equatable/equatable.dart';

class Total extends Equatable {
  const Total({
    required this.totalpositive,
    required this.totalnegative,
    required this.totalcount,
    required this.flowId,
    required this.stageId,});

    final int totalpositive;
    final int totalnegative;
    final int totalcount;
    final String flowId;
    final String stageId;

  @override
  
  List<Object?> get props => [
    totalpositive,totalnegative,totalcount,flowId,stageId
  ];
}
  