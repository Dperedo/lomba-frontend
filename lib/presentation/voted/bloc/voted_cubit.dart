import 'package:flutter_bloc/flutter_bloc.dart';

class VotedLiveCubit extends Cubit<VotedLiveState>{
  VotedLiveCubit(): super(VotedLiveState());

  void makeVote(String postId, int voteValue){
    emit(state.copyWithMakeVote(postId: postId, voteValue: voteValue));
  }
  void changeCheckValue(String name, bool value) {
    emit(state.copyWithChangeCheck(name: name, changeState: value));
  }
}

class VotedLiveState{
  Map<String, bool> checks = <String, bool>{};
  Map<String, int> votes = <String, int>{};

  VotedLiveState(){
    checks.clear();
    checks.addEntries(<String, bool>{'positive':false}.entries);
    checks.addEntries(<String, bool>{'negative':false}.entries);
  }

  VotedLiveState copyWithChangeCheck(
      {required String name, required bool changeState}) {
    final ous = VotedLiveState();
    ous.checks = checks;
    ous.votes = votes;
    ous.checks[name] = changeState;
    return ous;
  }

  VotedLiveState copyWithMakeVote(
      {required String postId, required int voteValue}) {
    final ous = VotedLiveState();
    ous.checks = checks;
    ous.votes = votes;
    ous.votes[postId] = voteValue;
    return ous;
  }
}