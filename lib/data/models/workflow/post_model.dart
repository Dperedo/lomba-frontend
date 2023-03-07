import 'package:lomba_frontend/domain/entities/workflow/post.dart';

class PostModel extends Post{
  const PostModel({
    required id, 
    required title, 
    required orgaId, 
    required userId, 
    required flowId, 
    required stageId, 
    required enabled, 
    required builtIn, 
    required created, 
    required stages, 
    required postitems, 
    required totals, 
    required tracks, 
    required votes,
    required updated, 
    required deleted, 
    required expires}) 
    : super(
      id: id,
      enabled: enabled,
      builtIn: builtIn,
      created: created,
      stages: stages,
      title: title,
      orgaId: orgaId,
      userId: userId,
      flowId: flowId,
      stageId: stageId,
      postitems: postitems,
      totals: totals,
      tracks: tracks,
      votes: votes,
      updated: updated,
      deleted: deleted,
      expires: expires
    );

  factory PostModel.fromJson(Map<String, dynamic> json){
    return PostModel(
      id: json['id'],
      enabled: json['enabled'],
      builtIn: json['builtIn'],
      created: json['created'],
      stages: json['stages'],
      title: json['titles'],
      orgaId: json['orgaId'],
      userId: json['userId'],
      flowId: json['flowId'],
      stageId: json['stageId'],
      postitems: json['postitems'],
      totals: json['totals'],
      tracks: json['tracks'],
      votes: json['votes'],
      updated: json['updated'],
      deleted: json['deleted'],
      expires: json['expires']
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'enabled': enabled,
      'builtIn': builtIn,
      'created': created,
      'stages': stages,
      'title': title,
      'orgaId': orgaId,
      'userId': userId,
      'flowId': flowId,
      'stageId': stageId,
      'postitems': postitems,
      'totals': totals,
      'tracks': tracks,
      'votes' : votes,
      'updated': updated,
      'deleted': deleted,
      'expires': expires
    };
  }

  Post toEntity() => Post(
      id: id,
      enabled: enabled,
      builtIn: builtIn,
      created: created,
      stages: stages,
      title: title,
      orgaId: orgaId,
      userId: userId,
      flowId: flowId,
      stageId: stageId,
      postitems: postitems,
      totals: totals,
      tracks: tracks,
      votes: votes,
      updated: updated,
      deleted: deleted,
      expires: expires
  );

  @override
  List<Object> get props => [id, enabled, builtIn, created, stages, title,orgaId, userId,
    flowId, stageId, postitems, totals, tracks, votes];
}