import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/model_container.dart';
import 'package:lomba_frontend/domain/entities/workflow/textcontent.dart';

import '../../core/failures.dart';
import '../entities/workflow/imagecontent.dart';
import '../entities/workflow/post.dart';
import '../entities/workflow/sourcecontent.dart';
import '../entities/workflow/videocontent.dart';
import '../entities/workflow/vote.dart';

abstract class PostRepository {
  Future<Either<Failure, Post>> addTextPost(String orgaId, String userId,
      TextContent text, String title, String flowId, bool isDraft);
  Future<Either<Failure, Post>> addMultiPost(
      String orgaId,
      String userId,
      TextContent? text,
      ImageContent? image,
      VideoContent? video,
      List<SourceContent>? sources,
      String title,
      String flowId,
      bool isDraft);
  Future<Either<Failure, Post>> updateMultiPost(
      String postId,
      String userId,
      TextContent? text,
      ImageContent? image,
      VideoContent? video,
      List<SourceContent>? sources,
      String title);
  Future<Either<Failure, Post>> changeStagePost(
      String postId, String flowId, String stageId);
  Future<Either<Failure, Post>> getPost(String postId);
  Future<Either<Failure, Post>> getPostWithUser(
      String postId, String userId, String flowId, String stageId);
  Future<Either<Failure, Post>> enablePost(String postId, bool enableOrDisable);
  Future<Either<Failure, Post>> deletePost(String postId, String userId);
  Future<Either<Failure, ModelContainer<Post>>> getUploadedPosts(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      bool onlyDrafts,
      String searchText,
      Map<String, int> fieldsOrder,
      int pageIndex,
      int pageSize);
  Future<Either<Failure, ModelContainer<Post>>> getForApprovePosts(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String searchText,
      Map<String, int> fieldsOrder,
      int pageIndex,
      int pageSize);
  Future<Either<Failure, ModelContainer<Post>>> getApprovedPosts(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String searchText,
      Map<String, int> fieldsOrder,
      int pageIndex,
      int pageSize);
  Future<Either<Failure, ModelContainer<Post>>> getRejectedPosts(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String searchText,
      Map<String, int> fieldsOrder,
      int pageIndex,
      int pageSize);
  Future<Either<Failure, ModelContainer<Post>>> getLatestPosts(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String searchText,
      int pageIndex,
      int pageSize);
  Future<Either<Failure, ModelContainer<Post>>> getPopularPosts(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String searchText,
      int pageIndex,
      int pageSize);
  Future<Either<Failure, ModelContainer<Post>>> getVotedPosts(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String searchText,
      Map<String, int> fieldsOrder,
      int pageIndex,
      int pageSize,
      int voteState);
  Future<Either<Failure, ModelContainer<Post>>> getFavoritesPosts(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String searchText,
      Map<String, int> fieldsOrder,
      int pageIndex,
      int pageSize,
      int voteState);
  Future<Either<Failure, ModelContainer<Post>>> getSavedPosts(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String searchText,
      Map<String, int> fieldsOrder,
      int pageIndex,
      int pageSize,
      int voteState);
  Future<Either<Failure, ModelContainer<Vote>>> votePublication(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String postId,
      int voteValue);
  Future<Either<Failure, ModelContainer<Post>>> getDetailedListPosts(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String searchText,
      Map<String, int> fieldsOrder,
      int pageIndex,
      int pageSize,
      int enableValue);
}
