import 'package:equatable/equatable.dart';

class Vote extends Equatable {
  const Vote({
    required this.id,
    required this.flowId,
    required this.stageId,
    required this.userId,
    required this.key,
    required this.value,
    required this.created,
    required this.updated,
    required this.deleted,
    required this.expires,
  });

  final String id;
  final String flowId;
  final String stageId;
  final String key;
  final int value;
  final String userId;
  final DateTime created;
  final DateTime? updated;
  final DateTime? deleted;
  final DateTime? expires;

  @override
  List<Object?> get props => [id, flowId, stageId, key, value, userId, created];
}
