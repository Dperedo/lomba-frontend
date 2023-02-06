import 'package:equatable/equatable.dart';

abstract class AddContentEvent extends Equatable {
  const AddContentEvent();

  @override
  List<Object?> get props => [];
}

class OnAddContentAdd extends AddContentEvent {
  final String flowId;
  final String titles;
  final String content;
  final bool draft;

  const OnAddContentAdd(this.flowId, this.titles, this.content, this.draft);

  @override
  List<Object> get props => [flowId, titles, content, draft];
}