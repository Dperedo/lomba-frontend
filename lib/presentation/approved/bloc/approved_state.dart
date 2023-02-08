import 'package:equatable/equatable.dart';

abstract class AddrovedState extends Equatable {
  const AddrovedState();

  @override
  List<Object> get props => [];
}

class AddrovedStart extends AddrovedState {}

class AddrovedLoading extends AddrovedState {}

class AddrovedError extends AddrovedState {
  final String message;

  const AddrovedError(this.message);

  @override
  List<Object> get props => [message];
}

