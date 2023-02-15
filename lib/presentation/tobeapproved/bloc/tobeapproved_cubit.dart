import 'package:flutter_bloc/flutter_bloc.dart';

class ToBeApprovedLiveCubit extends Cubit<ToBeApprovedLiveState> {
  ToBeApprovedLiveCubit() : super(ToBeApprovedLiveState());

  void changeCheckValue(String name, bool value) {
    emit(state.copyWithChangeCheck(name: name, changeState: value));
  }

  void makeVote(String postId, int voteValue) {
    emit(state.copyWithMakeVote(postId: postId, voteValue: voteValue));
  }
}

class ToBeApprovedLiveState {
  Map<String, bool> checks = <String, bool>{};
  Map<String, int> votes = <String, int>{};

  ToBeApprovedLiveState() {
    checks.clear();
    checks.addEntries(<String, bool>{"onlydrafts": false}.entries);
  }

  ToBeApprovedLiveState copyWithChangeCheck(
      {required String name, required bool changeState}) {
    final ous = ToBeApprovedLiveState();
    ous.checks = checks;
    ous.votes = votes;
    ous.checks[name] = changeState;
    return ous;
  }

  ToBeApprovedLiveState copyWithMakeVote(
      {required String postId, required int voteValue}) {
    final ous = ToBeApprovedLiveState();
    ous.checks = checks;
    ous.votes = votes;
    ous.votes[postId] = voteValue;
    return ous;
  }
}
