import 'package:equatable/equatable.dart';

class OrgaUser extends Equatable {
  const OrgaUser(
      {required this.userId,
      required this.orgaId,
      required this.roles,
      required this.enabled,
      required this.builtIn});

  final String userId;
  final String orgaId;
  final List<String> roles;
  final bool enabled;
  final bool builtIn;

  @override
  List<Object> get props => [userId, orgaId, roles, enabled, builtIn];
}
