import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoaded extends HomeState {
  final bool validLogin;

  HomeLoaded(this.validLogin);
}

class HomeStart extends HomeState {}
