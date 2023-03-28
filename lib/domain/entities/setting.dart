import 'package:equatable/equatable.dart';

class Setting extends Equatable {
  const Setting({
    required this.id,
    required this.code,
    required this.value,
    required this.orgaId,
    required this.builtIn,
    required this.created,
    required this.updated
    });

  final String id;
  final String code;
  final String value;
  final String? orgaId;
  final bool builtIn;
  final DateTime created;
  final DateTime? updated;

  @override
  List<Object> get props => [id, code, value, builtIn, created];
}
