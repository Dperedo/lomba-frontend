import 'package:equatable/equatable.dart';

abstract class SideDrawerEvent extends Equatable {
  const SideDrawerEvent();

  @override
  List<Object?> get props => [];
}

class OnSideDrawerLoading extends SideDrawerEvent {
  const OnSideDrawerLoading();

  @override
  List<Object?> get props => [];
}

class OnSideDrawerReady extends SideDrawerEvent {
  const OnSideDrawerReady();

  @override
  List<Object?> get props => [];
}
