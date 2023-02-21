import 'package:flutter_bloc/flutter_bloc.dart';

class PopularLiveCubit extends Cubit<PopularLiveState> {
  PopularLiveCubit() : super(PopularLiveState());

  void changeCheckValue(String name, bool value) {
    emit(state.copyWithChangeCheck(name: name, changeState: value));
  }

  void makeVote(String postId, int voteValue) {
    emit(state.copyWithMakeVote(postId: postId, voteValue: voteValue));
  }
}

class PopularLiveState {
  Map<String, bool> checks = <String, bool>{};
  Map<String, int> votes = <String, int>{};

  PopularLiveState() {
    checks.clear();
    checks.addEntries(<String, bool>{"onlydrafts": false}.entries);
  }

  PopularLiveState copyWithChangeCheck(
      {required String name, required bool changeState}) {
    final ous = PopularLiveState();
    ous.checks = checks;
    ous.votes = votes;
    ous.checks[name] = changeState;
    return ous;
  }

  PopularLiveState copyWithMakeVote(
      {required String postId, required int voteValue}) {
    final ous = PopularLiveState();
    ous.checks = checks;
    ous.votes = votes;
    ous.votes[postId] = voteValue;
    return ous;
  }
}