import 'package:equatable/equatable.dart';

class Host extends Equatable {
  const Host(
      {required this.id,
      required this.host,
      required this.names,});

  final String id;
  final String host;
  final List<String> names;

  @override
  List<Object?> get props =>
      [id, host, names];
}
