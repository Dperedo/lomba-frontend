import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/comment/delete_comment.dart';
import 'package:lomba_frontend/domain/usecases/comment/post_comment.dart';

import '../../../core/constants.dart';
import '../../../domain/entities/workflow/comment.dart';
import '../../../domain/usecases/bookmark/post_bookmark.dart';
import '../../../domain/usecases/comment/get_comments_post.dart';
import '../../../domain/usecases/users/get_user.dart';

class PostLiveCubit extends Cubit<PostLiveState> {
  final PostBookmark _postBookmark;
  final GetComments _getComments;
  final PostComment _postComment;
  final DeleteComment _deleteComment;
  final GetUser _getUser;
  PostLiveCubit(
    this._postBookmark,
    this._getComments,
    this._postComment,
    this._deleteComment,
    this._getUser,
  )
      : super(const PostLiveState(
        <String, bool>{},
        <String, int>{},
        <String, bool>{},
        <String, bool>{},
        []));

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
      if(r.markType == BookmarkCodes.saveCode) {
        emit(state.copyWithSave(postId: postId, saveValue: giveOrTakeAway));
      } else if (r.markType == BookmarkCodes.favCode) {
        emit(state.copyWithFav(postId: postId, favValue: giveOrTakeAway));
      }
    });
  }

  void postComment(String userId, String postId, String comment, List<Comment> list) async {
    final resultComment = await _postComment.execute(userId, postId, comment);
    resultComment.fold((l) => null, (r) {
      getComments(postId);
      //list.add(r);
      //emit(state.copyWithGetComments(commentList: list));
    });
  }

  void getComments(String postId) async {
    const Map<String, String> listFields = <String, String>{"Creación": "created"};
    final resultComments = await _getComments.execute(postId,<String, int>{"created": -1}, 1, 10, 1);
    resultComments.fold((l) => null, (r) {
      emit(state.copyWithGetComments(commentList: r));
    });
  }

  void deleteComment(String userId, String postId, String commentId) async {
    final resultDelete = await _deleteComment.execute(userId, postId, commentId);
    resultDelete.fold((l) => null, (r) {
      getComments(postId);
    });
  }

  void getUserName(String userId) async {
    final resultUser = await _getUser.execute(userId);
    resultUser.fold((l) => null, (r) {
      return r.name;
      //getComments(postId);
    });
  }
}

class PostLiveState extends Equatable {
  final Map<String, bool> checks;
  final Map<String, int> votes;
  final Map<String, bool> favs;
  final Map<String, bool> saves;
  final List<Comment> commentList;

  @override
  List<Object?> get props => [checks, votes, votes.length, favs, saves, commentList];

  const PostLiveState(this.checks, this.votes, this.favs, this.saves, this.commentList);

  PostLiveState copyWithChangeCheck(
      {required String name, required bool changeState}) {
    Map<String, bool> nchecks = <String, bool>{};
    nchecks.addAll(checks);
    nchecks[name] = changeState;
    final ous = PostLiveState(nchecks, votes, favs, saves, commentList);
    return ous;
  }

  PostLiveState copyWithMakeVote(
      {required String postId, required int voteValue}) {
    Map<String, int> nvotes = <String, int>{};
    nvotes.addAll(votes);
    nvotes[postId] = voteValue;
    final ous = PostLiveState(checks, nvotes, favs, saves, commentList);
    return ous;
  }

  PostLiveState copyWithSave(
      {required String postId, required bool saveValue}) {
    Map<String, bool> nsaves = <String, bool>{};
    nsaves.addAll(saves);
    nsaves[postId] = saveValue;
    final ous = PostLiveState(checks, votes, nsaves, favs, commentList);
    return ous;
  }

  PostLiveState copyWithFav({required String postId, required bool favValue}) {
    Map<String, bool> nfavs = <String, bool>{};
    nfavs.addAll(favs);
    nfavs[postId] = favValue;
    final ous = PostLiveState(checks, votes, saves, nfavs, commentList);
    return ous;
  }

  /*PostLiveState copyWithAddComment(
      {required String postId, required Comment comment}) {
    Map<String, List<Comment>> ncomments = <String, List<Comment>>{};
    ncomments.addAll(comments);
    if (ncomments[postId] == null) {
      ncomments[postId] = <Comment>[];
    }
    ncomments[postId]!.add(comment);
    final ous = PostLiveState(checks, votes, saves, favs);
    return ous;
  }*/

  /*PostLiveState copyWithAddComment(
      {required String postId, required Comment comment}) {
    List<Comment> ncomments = commentList;
    ncomments.add(comment);
    final ous = PostLiveState(checks, votes, saves, favs, ncomments);
    return ous;
  }*/

  PostLiveState copyWithGetComments({required List<Comment> commentList}) {
    final ous = PostLiveState(checks, votes, saves, favs, commentList);
    return ous;
  }
}
