import 'package:equatable/equatable.dart';

class FileCloud extends Equatable {
  const FileCloud(
      {required this.id,
      required this.name,
      required this.path,
      required this.url,
      required this.size,
      required this.account,
      required this.filetype,
      required this.enabled,
      required this.builtIn,
      required this.created,
      required this.updated,
      required this.deleted,
      required this.expires});

  final String id;
  final String name;
  final String path;
  final String url;
  final int size;
  final String account;
  final String filetype;
  final bool builtIn;
  final DateTime created;
  final DateTime? updated;
  final DateTime? deleted;
  final DateTime? expires;
  final bool enabled;

  @override
  List<Object?> get props =>
      [id, name, url, size, account, filetype, enabled, builtIn, created];
}
