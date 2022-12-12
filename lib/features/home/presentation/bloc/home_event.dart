import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class OnHomeLoading extends HomeEvent {
  const OnHomeLoading();

  @override
  List<Object?> get props => [];
}

class OnHomeLoaded extends HomeEvent {
  const OnHomeLoaded();

  @override
  List<Object?> get props => [];
}

class OnRestartHome extends HomeEvent {}
