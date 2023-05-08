import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../domain/usecases/bookmark/post_bookmark.dart';

class PostLiveCubit extends Cubit<PostLiveState> {
  final PostBookmark _postBookmark;
  PostLiveCubit(
    this._postBookmark,
  ) : super(const PostLiveState(
          <String, bool>{},
          <String, int>{},
          <String, bool>{},
          <String, bool>{},
        ));

  void changeCheckValue(String name, bool value) {
    emit(state.copyWithChangeCheck(name: name, changeState: value));
  }

  void makeVote(String postId, int voteValue) {
    emit(state.copyWithMakeVote(postId: postId, voteValue: voteValue));
  }

  void makeBookmark(String userId, String postId, String markType,
      bool giveOrTakeAway) async {
    final resultBookmark =
        await _postBookmark.execute(userId, postId, markType, giveOrTakeAway);
    resultBookmark.fold((l) => null, (r) {
      if (r.markType == BookmarkCodes.saveCode) {
        emit(state.copyWithSave(postId: postId, saveValue: giveOrTakeAway));
      } else if (r.markType == BookmarkCodes.favCode) {
        emit(state.copyWithFav(postId: postId, favValue: giveOrTakeAway));
      }
    });
  }
}

class PostLiveState extends Equatable {
  final Map<String, bool> checks;
  final Map<String, int> votes;
  final Map<String, bool> favs;
  final Map<String, bool> saves;

  @override
  List<Object?> get props => [checks, votes, votes.length, favs, saves];

  const PostLiveState(this.checks, this.votes, this.favs, this.saves);

  PostLiveState copyWithChangeCheck(
      {required String name, required bool changeState}) {
    Map<String, bool> nchecks = <String, bool>{};
    nchecks.addAll(checks);
    nchecks[name] = changeState;
    final ous = PostLiveState(nchecks, votes, favs, saves);
    return ous;
  }

  PostLiveState copyWithMakeVote(
      {required String postId, required int voteValue}) {
    Map<String, int> nvotes = <String, int>{};
    nvotes.addAll(votes);
    nvotes[postId] = voteValue;
    final ous = PostLiveState(checks, nvotes, favs, saves);
    return ous;
  }

  PostLiveState copyWithSave(
      {required String postId, required bool saveValue}) {
    Map<String, bool> nsaves = <String, bool>{};
    nsaves.addAll(saves);
    nsaves[postId] = saveValue;
    final ous = PostLiveState(checks, votes, nsaves, favs);
    return ous;
  }

  PostLiveState copyWithFav({required String postId, required bool favValue}) {
    Map<String, bool> nfavs = <String, bool>{};
    nfavs.addAll(favs);
    nfavs[postId] = favValue;
    final ous = PostLiveState(checks, votes, saves, nfavs);
    return ous;
  }
}
