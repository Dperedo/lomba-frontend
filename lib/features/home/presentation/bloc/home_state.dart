import 'package:equatable/equatable.dart';

///Interfaz de los estados de Home.
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

///Estado de Home que sabe si el usuario está logueado o no.
class HomeLoaded extends HomeState {
  final bool validLogin;

  const HomeLoaded(this.validLogin);
}

///Estado inicial del Home
class HomeStart extends HomeState {}

///Estado que indica que la información se está cargando.
///
///Este estado sirve para mostrar el spinner (círculo que gira) mientras
///el trabajo se está realizando.
class HomeLoading extends HomeState {}
