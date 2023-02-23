import 'package:equatable/equatable.dart';

import '../../nav/bloc/nav_state.dart';

abstract class RouterPageEvent extends Equatable {
  const RouterPageEvent();

  @override
  List<Object?> get props => [];
}

class OnRouterPageLoading extends RouterPageEvent {
  final NavItem destination;
  const OnRouterPageLoading(this.destination);
}

class OnRouterPageReset extends RouterPageEvent {
  const OnRouterPageReset();
}

