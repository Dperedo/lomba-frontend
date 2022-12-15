import 'package:equatable/equatable.dart';

class Orga extends Equatable {
  const Orga(
      {required this.id,
      required this.name,
      required this.code,
      required this.enabled,
      required this.builtIn});

  final String id;
  final String name;
  final String code;
  final bool enabled;
  final bool builtIn;

  @override
  List<Object> get props => [id, name, code, enabled, builtIn];
}
