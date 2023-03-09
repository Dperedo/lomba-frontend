import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VotedLiveCubit extends Cubit<VotedLiveState> {
  VotedLiveCubit()
      : super(const VotedLiveState(
            <String, bool>{'positive': false, 'negative': false},
            <String, int>{}));

  void makeVote(String postId, int voteValue) {
    emit(state.copyWithMakeVote(postId: postId, voteValue: voteValue));
  }

  void changeCheckValue(String name, bool value) {
    emit(state.copyWithChangeCheck(name: name, changeState: value));
  }
}

class VotedLiveState extends Equatable {
  final Map<String, bool> checks;
  final Map<String, int> votes;
  @override
  List<Object?> get props => [checks, votes, votes.length];

  const VotedLiveState(this.checks, this.votes);

  VotedLiveState copyWithChangeCheck(
      {required String name, required bool changeState}) {
    Map<String, bool> nchecks = <String, bool>{};
    nchecks.addAll(checks);
    nchecks[name] = changeState;
    final ous = VotedLiveState(nchecks, votes);
    return ous;
  }

  VotedLiveState copyWithMakeVote(
      {required String postId, required int voteValue}) {
    Map<String, int> nvotes = <String, int>{};
    nvotes.addAll(votes);
    nvotes[postId] = voteValue;
    final ous = VotedLiveState(checks, nvotes);
    return ous;
  }
}
