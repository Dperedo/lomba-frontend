import 'package:equatable/equatable.dart';

abstract class RouterPageState extends Equatable {
  const RouterPageState();

  @override
  List<Object> get props => [];
}

class RouterPageEmpty extends RouterPageState{}

class RouterPageError extends RouterPageState {
  final String message;
  const RouterPageError (this.message);
  @override
  List<Object> get props => [message];
}

class RouterPageRole extends RouterPageState {
  //const RouterPageRole ();
}

//class RouterPageEmpty extends RouterPageState{}