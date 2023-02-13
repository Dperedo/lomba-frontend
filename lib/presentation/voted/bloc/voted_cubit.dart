import 'package:flutter_bloc/flutter_bloc.dart';

class VotedLiveCubit extends Cubit<VotedLiveState>{
  VotedLiveCubit(): super(VotedLiveState());

  void makeVote(String postId, int voteValue){
    emit(state.copyWithMakeVote(postId: postId, voteValue: voteValue));
  }
}

class VotedLiveState{
  Map<String, bool> checks = <String, bool>{};
  Map<String, int> votes = <String, int>{};

  VotedLiveState copyWithMakeVote(
      {required String postId, required int voteValue}) {
    final ous = VotedLiveState();
    ous.checks = checks;
    ous.votes = votes;
    ous.votes[postId] = voteValue;
    return ous;
  }
}