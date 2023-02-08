import 'package:equatable/equatable.dart';

abstract class AddContentEvent extends Equatable {
  const AddContentEvent();

  @override
  List<Object?> get props => [];
}

class OnAddContentAdd extends AddContentEvent {
  final String flowId;
  final String title;
  final String text;
  final bool isDraft;

  const OnAddContentAdd(this.flowId, this.title, this.text, this.isDraft);

  @override
  List<Object> get props => [flowId, title, text, isDraft];
}

class OnAddContentUp extends AddContentEvent {

  const OnAddContentUp();
  @override
  List<Object> get props => [];
}