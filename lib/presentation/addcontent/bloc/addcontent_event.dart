import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:lomba_frontend/domain/entities/storage/cloudfile.dart';

abstract class AddContentEvent extends Equatable {
  const AddContentEvent();

  @override
  List<Object?> get props => [];
}

class OnAddContentAdd extends AddContentEvent {
  final String title;
  final String text;
  final CloudFile? cloudFile;
  final bool isDraft;
  final int mediaHeight;
  final int mediaWidth;

  const OnAddContentAdd(
    this.title,
    this.text,
    this.cloudFile,
    this.isDraft,
    this.mediaHeight,
    this.mediaWidth,
  );

  @override
  List<Object> get props => [title, isDraft, mediaHeight, mediaWidth];
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
