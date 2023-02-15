import 'package:equatable/equatable.dart';

class Stage extends Equatable {
  const Stage({
    required this.id,
    required this.name,
    required this.order,
    required this.queryOut,
    required this.enabled,
    required this.builtIn,
    required this.created,
    required this.updated,
    required this.deleted,
    required this.expires,
  });

  final String id;
  final String name;
  final int order;
  final Object? queryOut;
  final bool builtIn;
  final DateTime created;
  final DateTime? updated;
  final DateTime? deleted;
  final DateTime? expires;
  final bool enabled;

  @override
  List<Object?> get props =>
      [id, name, order, queryOut, enabled, builtIn, created];
}
