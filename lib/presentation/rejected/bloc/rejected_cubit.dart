import 'package:flutter_bloc/flutter_bloc.dart';

class RejectedLiveCubit extends Cubit<RejectedLiveState> {
  RejectedLiveCubit() : super(RejectedLiveState());

  void changeCheckValue(String name, bool value) {
    emit(state.copyWithChangeCheck(name: name, changeState: value));
  }

  void makeVote(String postId, int voteValue) {
    emit(state.copyWithMakeVote(postId: postId, voteValue: voteValue));
  }
}

class RejectedLiveState {
  Map<String, bool> checks = <String, bool>{};
  Map<String, int> votes = <String, int>{};

  RejectedLiveState() {
    checks.clear();
    checks.addEntries(<String, bool>{"onlydrafts": false}.entries);
  }

  RejectedLiveState copyWithChangeCheck(
      {required String name, required bool changeState}) {
    final ous = RejectedLiveState();
    ous.checks = checks;
    ous.votes = votes;
    ous.checks[name] = changeState;
    return ous;
  }

  RejectedLiveState copyWithMakeVote(
      {required String postId, required int voteValue}) {
    final ous = RejectedLiveState();
    ous.checks = checks;
    ous.votes = votes;
    ous.votes[postId] = voteValue;
    return ous;
  }
}