import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}
class OnProfileLoad extends ProfileEvent {
  final String? id;

  const OnProfileLoad(this.id);

  @override
  List<Object> get props => [id!];
}
