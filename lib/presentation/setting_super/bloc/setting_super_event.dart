import 'package:equatable/equatable.dart';

abstract class SettingSuperEvent extends Equatable {
  const SettingSuperEvent();

  @override
  List<Object?> get props => [];
}

class OnSettingSuperLoad extends SettingSuperEvent {
  const OnSettingSuperLoad();

  @override
  List<Object> get props => [];
}

class OnSettingSuperEdit extends SettingSuperEvent {
  final String id;
  final String code;
  const OnSettingSuperEdit(this.id, this.code);

  @override
  List<Object> get props => [id, code];
}

class OnSettingSuperStarter extends SettingSuperEvent {}
