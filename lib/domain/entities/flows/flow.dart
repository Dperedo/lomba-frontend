import 'package:equatable/equatable.dart';
import 'package:lomba_frontend/domain/entities/flows/stage.dart';

class Flow extends Equatable {
  const Flow({
    required this.id,
    required this.name,
    required this.enabled,
    required this.builtIn,
    required this.created,
    required this.updated,
    required this.deleted,
    required this.expires,
    required this.stages});

    final String id;
    final String name;
    final List<Stage> stages;
    final bool builtIn;
    final DateTime created;
    final DateTime? updated;
    final DateTime? deleted;
    final DateTime? expires;
    final bool enabled;

  @override
  
  List<Object?> get props => [
    id, name, enabled, builtIn, created, stages
  ];
}