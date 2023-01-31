import 'package:equatable/equatable.dart';
import 'package:lomba_frontend/domain/entities/flows/postitem.dart';
import 'package:lomba_frontend/domain/entities/flows/stage.dart';
import 'package:lomba_frontend/domain/entities/flows/total.dart';
import 'package:lomba_frontend/domain/entities/flows/track.dart';

class Post extends Equatable {
  const Post({
    required this.id,
    required this.enabled,
    required this.builtIn,
    required this.created,
    required this.stages,
    required this.title,
    required this.orgaId,
    required this.userId,
    required this.flowId,
    required this.stageId,
    required this.postitems,
    required this.totals,
    required this.tracks,
    required this.updated,
    required this.deleted,
    required this.expires,});

    final String id;
    final String title;
    final String orgaId;
    final String userId;
    final String flowId;
    final String stageId;
    final List<PostItem> postitems;
    final List<Stage> stages;
    final List<Total> totals;
    final List<Track> tracks;
    final bool builtIn;
    final DateTime created;
    final DateTime? updated;
    final DateTime? deleted;
    final DateTime? expires;
    final bool enabled;

  @override
  
  List<Object?> get props => [
    id,enabled,builtIn,created,stages,title,orgaId,userId,flowId,stageId,postitems,totals,tracks
  ];
}