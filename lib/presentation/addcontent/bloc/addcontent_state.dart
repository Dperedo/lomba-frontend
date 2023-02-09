import 'package:equatable/equatable.dart';

abstract class AddContentState extends Equatable {
  const AddContentState();

  @override
  List<Object> get props => [];
}

class AddContentEmpty extends AddContentState {}

class AddContentLoading extends AddContentState {}

class AddContentUp extends AddContentState {}

class AddContentError extends AddContentState {
  final String message;

  const AddContentError(this.message);

  @override
  List<Object> get props => [message];
}