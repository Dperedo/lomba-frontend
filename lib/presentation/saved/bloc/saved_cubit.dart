import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedLiveCubit extends Cubit<SavedLiveState> {
  SavedLiveCubit()
      : super(const SavedLiveState(
            <String, bool>{'positive': false, 'negative': false},
            <String, int>{}));

  void makeVote(String postId, int voteValue) {
    emit(state.copyWithMakeVote(postId: postId, voteValue: voteValue));
  }

  void changeCheckValue(String name, bool value) {
    emit(state.copyWithChangeCheck(name: name, changeState: value));
  }
}

class SavedLiveState extends Equatable {
  final Map<String, bool> checks;
  final Map<String, int> votes;
  @override
  List<Object?> get props => [checks, votes, votes.length];

  const SavedLiveState(this.checks, this.votes);

  SavedLiveState copyWithChangeCheck(
      {required String name, required bool changeState}) {
    Map<String, bool> nchecks = <String, bool>{};
    nchecks.addAll(checks);
    nchecks[name] = changeState;
    if (name == "positive" && changeState) nchecks["negative"] = !changeState;
    if (name == "negative" && changeState) nchecks["positive"] = !changeState;
    final ous = SavedLiveState(nchecks, votes);
    return ous;
  }

  SavedLiveState copyWithMakeVote(
      {required String postId, required int voteValue}) {
    Map<String, int> nvotes = <String, int>{};
    nvotes.addAll(votes);
    nvotes[postId] = voteValue;
    final ous = SavedLiveState(checks, nvotes);
    return ous;
  }
}
