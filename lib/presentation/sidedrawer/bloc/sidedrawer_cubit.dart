import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SidedrawerLiveCubit extends Cubit<SidedrawerLiveState> {
  SidedrawerLiveCubit()
      : super(const SidedrawerLiveState(
            false,));

  void changeSwitchValue(bool value) {
    emit(state.copyWithChangeCheck(changeState: value));
  }

  /*void makeVote(String postId, int voteValue) {
    emit(state.copyWithMakeVote(postId: postId, voteValue: voteValue));
  }*/
}

class SidedrawerLiveState extends Equatable {
  final bool isDarkMode;

  @override
  List<Object?> get props => [isDarkMode];

  const SidedrawerLiveState(this.isDarkMode);

  SidedrawerLiveState copyWithChangeCheck(
      {required bool changeState}) {
    
    final ous = SidedrawerLiveState(changeState);
    return ous;
  }

}
