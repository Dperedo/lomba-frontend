import 'package:equatable/equatable.dart';
import 'package:lomba_frontend/domain/entities/workflow/postitem.dart';
import 'package:lomba_frontend/domain/entities/workflow/stage.dart';
import 'package:lomba_frontend/domain/entities/workflow/total.dart';
import 'package:lomba_frontend/domain/entities/workflow/track.dart';
import 'package:lomba_frontend/domain/entities/workflow/vote.dart';

import 'bookmark.dart';

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
    required this.votes,
    required this.bookmarks,
    required this.updated,
    required this.deleted,
    required this.expires,
    required this.totalfavs,
    required this.totalsaves,
    required this.totalcomments,
    required this.totalreports,
    required this.totaldownloads,
  });

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
  final List<Vote> votes;
  final List<Bookmark> bookmarks;
  final bool builtIn;
  final DateTime created;
  final DateTime? updated;
  final DateTime? deleted;
  final DateTime? expires;
  final bool enabled;
  final int totalfavs;
  final int totalsaves;
  final int totalreports;
  final int totalcomments;
  final int totaldownloads;

  @override
  List<Object?> get props => [
        id,
        enabled,
        builtIn,
        created,
        stages,
        title,
        orgaId,
        userId,
        flowId,
        stageId,
        postitems,
        totals,
        tracks,
        votes,
        bookmarks,
        totalfavs,
        totalsaves,
        totalreports,
        totalcomments,
        totaldownloads,
      ];
}
