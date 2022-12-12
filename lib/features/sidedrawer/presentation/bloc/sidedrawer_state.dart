import 'package:equatable/equatable.dart';

abstract class SideDrawerState extends Equatable {
  const SideDrawerState();

  @override
  List<Object> get props => [];
}

class SideDrawerEmpty extends SideDrawerState {}

class SideDrawerLoading extends SideDrawerState {}

class SideDrawerReady extends SideDrawerState {
  final List<String> opts;
  const SideDrawerReady(this.opts);
  @override
  List<Object> get props => [opts];
}
