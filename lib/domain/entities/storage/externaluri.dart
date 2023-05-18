import 'package:equatable/equatable.dart';
import 'package:lomba_frontend/domain/entities/storage/host.dart';

class ExternalUri extends Equatable {
  const ExternalUri(
      {required this.id,
      required this.userId,
      required this.uri,
      required this.path,
      required this.host,
      required this.hosts,
      required this.sourceName,
      required this.title,
      required this.shortUrl,
      required this.description,
      required this.type,
      required this.httpstatus,
      required this.lastchecked,});

  final String id;
  final String userId;
  final String uri;
  final String path;
  final String host;
  final List<Host> hosts;
  final String sourceName;
  final String title;
  final String shortUrl;
  final String description;
  final String type;
  final int httpstatus;
  final DateTime? lastchecked;

  @override
  List<Object?> get props =>
      [id, userId, uri, path, host, hosts, sourceName, title, shortUrl, description, type, httpstatus, lastchecked];
}
