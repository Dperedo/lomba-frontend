import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToBeApprovedLiveCubit extends Cubit<ToBeApprovedLiveState> {
  ToBeApprovedLiveCubit()
      : super(const ToBeApprovedLiveState(<String, bool>{}, <String, int>{}));

  void changeCheckValue(String name, bool value) {
    emit(state.copyWithChangeCheck(name: name, changeState: value));
  }

  void makeVote(String postId, int voteValue) {
    emit(state.copyWithMakeVote(postId: postId, voteValue: voteValue));
  }
}

class ToBeApprovedLiveState extends Equatable {
  final Map<String, bool> checks;
  final Map<String, int> votes;

  @override
  List<Object?> get props => [checks, votes, votes.length];

  const ToBeApprovedLiveState(this.checks, this.votes);

  ToBeApprovedLiveState copyWithChangeCheck(
      {required String name, required bool changeState}) {
    Map<String, bool> nchecks = <String, bool>{};
    nchecks.addAll(checks);
    nchecks[name] = changeState;
    final ous = ToBeApprovedLiveState(nchecks, votes);
    return ous;
  }

  ToBeApprovedLiveState copyWithMakeVote(
      {required String postId, required int voteValue}) {
    Map<String, int> nvotes = <String, int>{};
    nvotes.addAll(votes);
    nvotes[postId] = voteValue;
    final ous = ToBeApprovedLiveState(checks, nvotes);
    return ous;
  }
}
