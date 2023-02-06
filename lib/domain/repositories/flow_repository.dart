import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/model_container.dart';

import '../../core/failures.dart';
import '../entities/flows/post.dart';

abstract class FlowRepository {
  Future<Either<Failure, Flow>> addTextPost(String orgaId, String userId, String text, String title, String flowId, bool isDraft);
  Future<Either<Failure, ModelContainer<Post>>> getUploadedPosts(String orgaId, String userId,String flowId,String stageId, bool onlyDrafts,String searchText,Map<String, int> fieldsOrder,int pageIndex,int pageSize);
  Future<Either<Failure, ModelContainer<Post>>> getForApprovePosts(String orgaId, String userId,String flowId,String stageId,String searchText,Map<String, int> fieldsOrder,int pageIndex,int pageSize);
  Future<Either<Failure, ModelContainer<Post>>> getApprovedPosts(String orgaId, String userId,String flowId,String stageId,String searchText,Map<String, int> fieldsOrder,int pageIndex,int pageSize);
  Future<Either<Failure, ModelContainer<Post>>> getRejectedPosts(String orgaId, String userId,String flowId,String stageId,String searchText,Map<String, int> fieldsOrder,int pageIndex,int pageSize);
  Future<Either<Failure, ModelContainer<Post>>> getLatestPosts(String orgaId, String userId,String flowId,String stageId,String searchText,int pageIndex,int pageSize);
  Future<Either<Failure, ModelContainer<Post>>> getPopularPosts(String orgaId, String userId,String flowId,String stageId,String searchText,int pageIndex,int pageSize);
  Future<Either<Failure, ModelContainer<Post>>> getVotedPosts(String orgaId, String userId,String flowId,String stageId,String searchText,Map<String, int> fieldsOrder,int pageIndex,int pageSize,int voteState);
  Future<Either<Failure, ModelContainer<Post>>> votePublication(String orgaId, String userId,String flowId, String stageId,String postId,int voteValue);
}
