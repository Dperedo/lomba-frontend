import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/model_container.dart';
import 'package:lomba_frontend/domain/entities/workflow/textcontent.dart';

import '../../core/failures.dart';
import '../entities/workflow/post.dart';
import '../entities/workflow/vote.dart';

abstract class PostRepository {
  Future<Either<Failure, Post>> addTextPost(String orgaId, String userId,
      TextContent text, String title, String flowId, bool isDraft);
  Future<Either<Failure, Post>> updatePost(String postId, String userId,
      TextContent text, String title);
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
      int pageIndex,
      int pageSize);
}
