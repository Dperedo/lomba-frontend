import 'package:flutter_bloc/flutter_bloc.dart';

class ApprovedLiveCubit extends Cubit<ApprovedLiveState> {
  ApprovedLiveCubit() : super(ApprovedLiveState());

  void changeCheckValue(String name, bool value) {
    emit(state.copyWithChangeCheck(name: name, changeState: value));
  }

  void makeVote(String postId, int voteValue) {
    emit(state.copyWithMakeVote(postId: postId, voteValue: voteValue));
  }
}

class ApprovedLiveState {
  Map<String, bool> checks = <String, bool>{};
  Map<String, int> votes = <String, int>{};

  ApprovedLiveState() {
    checks.clear();
    checks.addEntries(<String, bool>{"onlydrafts": false}.entries);
  }

  ApprovedLiveState copyWithChangeCheck(
      {required String name, required bool changeState}) {
    final ous = ApprovedLiveState();
    ous.checks = checks;
    ous.votes = votes;
    ous.checks[name] = changeState;
    return ous;
  }

  ApprovedLiveState copyWithMakeVote(
      {required String postId, required int voteValue}) {
    final ous = ApprovedLiveState();
    ous.checks = checks;
    ous.votes = votes;
    ous.votes[postId] = voteValue;
    return ous;
  }
}
