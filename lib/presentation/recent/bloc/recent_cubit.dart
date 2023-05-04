import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/constants.dart';

import '../../../domain/usecases/bookmark/post_bookmark.dart';

class RecentLiveCubit extends Cubit<RecentLiveState> {
  final PostBookmark _postBookmark;
  RecentLiveCubit(
    this._postBookmark,
  )
      : super(const RecentLiveState(<String, bool>{}, <String, int>{}, <String, bool>{}, <String, bool>{},));

  void changeCheckValue(String name, bool value) {
    emit(state.copyWithChangeCheck(name: name, changeState: value));
  }

  void makeVote(String postId, int voteValue) {
    emit(state.copyWithMakeVote(postId: postId, voteValue: voteValue));
  }

  void makeBookmark(String userId, String postId, String markType, bool giveOrTakeAway) async {

    final resultBookmark = await _postBookmark.execute(userId, postId, markType, giveOrTakeAway);
    resultBookmark.fold((l) => null, (r) {
      print(r);
      if(r.markType == BookmarkCodes.saveCode) {
        emit(state.copyWithSave(postId: postId, saveValue: giveOrTakeAway));
      } else if(r.markType == BookmarkCodes.favCode) {
        emit(state.copyWithFav(postId: postId, favValue: giveOrTakeAway));
      }
    });

  }
}

class RecentLiveState extends Equatable {
  final Map<String, bool> checks;
  final Map<String, int> votes;
  final Map<String, bool> favs;
  final Map<String, bool> saves;

  @override
  List<Object?> get props => [checks, votes, votes.length, saves, favs];

  const RecentLiveState(this.checks, this.votes, this.saves, this.favs);

  RecentLiveState copyWithChangeCheck(
      {required String name, required bool changeState}) {
    Map<String, bool> nchecks = <String, bool>{};
    nchecks.addAll(checks);
    nchecks[name] = changeState;
    final ous = RecentLiveState(nchecks, votes, saves, favs);
    return ous;
  }

  RecentLiveState copyWithMakeVote(
      {required String postId, required int voteValue}) {
    Map<String, int> nvotes = <String, int>{};
    nvotes.addAll(votes);
    nvotes[postId] = voteValue;
    final ous = RecentLiveState(checks, nvotes, saves, favs);
    return ous;
  }

  RecentLiveState copyWithSave({required String postId, required bool saveValue}) {
    Map<String, bool> nsaves = <String, bool>{};
    nsaves.addAll(saves);
    nsaves[postId] = saveValue;
    final ous = RecentLiveState(checks, votes, nsaves, favs);
    return ous;
  }

  RecentLiveState copyWithFav({required String postId, required bool favValue}) {
    Map<String, bool> nfavs = <String, bool>{};
    nfavs.addAll(favs);
    nfavs[postId] = favValue;
    final ous = RecentLiveState(checks, votes, saves, nfavs);
    return ous;
  }
}
