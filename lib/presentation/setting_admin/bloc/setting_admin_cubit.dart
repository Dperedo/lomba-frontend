import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingAdminLiveCubit extends Cubit<SettingAdminLiveState> {
  SettingAdminLiveCubit()
      : super(const SettingAdminLiveState(
            <String, bool>{"onlydrafts": false}, <String, int>{}));

  void changeCheckValue(String name, bool value) {
    emit(state.copyWithChangeCheck(name: name, changeState: value));
  }

  void makeVote(String postId, int voteValue) {
    emit(state.copyWithMakeVote(postId: postId, voteValue: voteValue));
  }
}

class SettingAdminLiveState extends Equatable {
  final Map<String, bool> checks;
  final Map<String, int> votes;

  @override
  List<Object?> get props => [checks, votes, votes.length];

  const SettingAdminLiveState(this.checks, this.votes);

  SettingAdminLiveState copyWithChangeCheck(
      {required String name, required bool changeState}) {
    Map<String, bool> nchecks = <String, bool>{};
    nchecks.addAll(checks);
    nchecks[name] = changeState;
    final ous = SettingAdminLiveState(nchecks, votes);
    return ous;
  }

  SettingAdminLiveState copyWithMakeVote(
      {required String postId, required int voteValue}) {
    Map<String, int> nvotes = <String, int>{};
    nvotes.addAll(votes);
    nvotes[postId] = voteValue;
    final ous = SettingAdminLiveState(checks, nvotes);
    return ous;
  }
}
