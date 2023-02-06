import 'package:equatable/equatable.dart';

abstract class AddContentState extends Equatable {
  const AddContentState();

  @override
  List<Object> get props => [];
}

class AddContentStart extends AddContentState {}

class AddContentLoading extends AddContentState {}

class AddContentAdded extends AddContentState {}