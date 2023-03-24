import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class AddContentEvent extends Equatable {
  const AddContentEvent();

  @override
  List<Object?> get props => [];
}

class OnAddContentAdd extends AddContentEvent {
  final String title;
  final String text;
  final bool isDraft;

  const OnAddContentAdd(this.title, this.text, this.isDraft);

  @override
  List<Object> get props => [title, text, isDraft];
}

class OnAddContentUp extends AddContentEvent {
  const OnAddContentUp();
  @override
  List<Object> get props => [];
}

class OnAddContentStarter extends AddContentEvent {}

class OnAddContentFile extends AddContentEvent {
  final Uint8List file;
  final String name;

  const OnAddContentFile(this.file, this.name);

  @override
  List<Object> get props => [file, name];
}
