import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class AddContentState extends Equatable {
  const AddContentState();

  @override
  List<Object> get props => [];
}

class AddContentStart extends AddContentState {}

class AddContentLoading extends AddContentState {}

class AddContentUp extends AddContentState {}

class AddContentError extends AddContentState {
  final String message;

  const AddContentError(this.message);

  @override
  List<Object> get props => [message];
}

class AddContentFile extends AddContentState {
  final String name;
  final Uint8List file;

  const AddContentFile(this.name, this.file);

  @override
  List<Object> get props => [name, file];
}
