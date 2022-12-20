import 'package:equatable/equatable.dart';

class Role extends Equatable {
  const Role({required this.name, required this.enabled});

  final String name;
  final bool enabled;

  @override
  List<Object> get props => [name, enabled];
}
