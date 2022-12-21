import 'package:equatable/equatable.dart';

///Entidad de organización [Orga].
///
///[id] identificador de la organización. Es único.
///[name] nombre o razón social de la organización.
///[code] nombre clave y único de la organización.
///[enabled] indica si la organización está habilitada o deshabilitada.
///[builtIn] si la organización es parte nativa del sistema.
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
