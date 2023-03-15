import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailedListLiveCubit extends Cubit<DetailedListLiveState> {
  DetailedListLiveCubit() 
    : super(DetailedListLiveState(
      const <String, bool>{'enabled': false, 'disabled': false},
      const <String, int>{}));

  void changeCheckValue(String name, bool value) {
    emit(state.copyWithChangeCheck(name: name, changeState: value));
  }

  void makeVote(String postId, int voteValue) {
    emit(state.copyWithMakeVote(postId: postId, voteValue: voteValue));
  }
}

class DetailedListLiveState extends Equatable {
  Map<String, bool> checks;// = <String, bool>{};
  Map<String, int> votes;

  @override
  List<Object?> get props => [checks, votes];

  DetailedListLiveState(this.checks, this.votes);

  /*DetailedListLiveState() {
    checks.clear();
  }*/

  DetailedListLiveState copyWithChangeCheck(
      {required String name, required bool changeState}) {
    Map<String, bool> nchecks = <String, bool>{};
    nchecks.addAll(checks);
    nchecks[name] = changeState;
    if (name == "enabled" && changeState) nchecks["disabled"] = !changeState;
    if (name == "disabled" && changeState) nchecks["enabled"] = !changeState;
    final ous = DetailedListLiveState(nchecks, votes);
    //ous.checks = checks;
    //ous.votes = votes;
    //ous.checks[name] = changeState;
    return ous;
  }

  DetailedListLiveState copyWithMakeVote(
      {required String postId, required int voteValue}) {
    Map<String, int> nvotes = <String, int>{};
    nvotes.addAll(votes);
    nvotes[postId] = voteValue;
    final ous = DetailedListLiveState(checks, nvotes);
    //ous.checks = checks;
    //ous.votes = votes;
    //ous.votes[postId] = voteValue;
    return ous;
  }
}
