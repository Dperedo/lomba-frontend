import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class Token extends Equatable {
  const Token({required this.id, required this.username});

  final String id;
  final String username;

  @override
  List<Object> get props => [id, username];
}
