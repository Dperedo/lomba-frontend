import '../../../domain/entities/workflow/vote.dart';

class VoteModel extends Vote {
  const VoteModel(
      {required id,
      required flowId,
      required stageId,
      required userId,
      required key,
      required value,
      required created,
      required updated,
      required deleted,
      required expires})
      : super(
            id: id,
            created: created,
            deleted: deleted,
            expires: expires,
            flowId: flowId,
            stageId: stageId,
            updated: updated,
            userId: userId,
            key: key,
            value: value);

  factory VoteModel.fromJson(Map<String, dynamic> json) {
    return VoteModel(
        id: json['id'],
        flowId: json['flowId'],
        stageId: json['stageId'],
        userId: json['userId'],
        key: json['key'],
        value: json['value'],
        created: json['created'],
        updated: json['updated'],
        deleted: json['deleted'],
        expires: json['expires']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'flowId': flowId,
      'stageId': stageId,
      'userId': userId,
      'key': key,
      'value': value,
      'created': created,
      'updated': updated,
      'deleted': deleted,
      'expires': expires
    };
  }
}
