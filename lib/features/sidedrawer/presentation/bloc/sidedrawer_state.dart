import 'package:equatable/equatable.dart';

import '../../../orgas/domain/entities/orga.dart';

abstract class SideDrawerState extends Equatable {
  const SideDrawerState();

  @override
  List<Object> get props => [];
}

class SideDrawerEmpty extends SideDrawerState {}

class SideDrawerLoading extends SideDrawerState {}

class SideDrawerReady extends SideDrawerState {
  final List<String> opts;
  final List<Orga> orgas;
  final String orgaId;
  const SideDrawerReady(this.opts, this.orgas, this.orgaId);
  @override
  List<Object> get props => [opts, orgas, orgaId];
}
