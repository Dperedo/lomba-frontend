import 'dart:io';

import 'package:flutter_guid/flutter_guid.dart';
import 'package:lomba_frontend/domain/entities/flows/post.dart';
import 'package:lomba_frontend/core/model_container.dart';
import 'package:lomba_frontend/core/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/domain/entities/flows/textcontent.dart';
import 'dart:developer';

import 'package:lomba_frontend/domain/repositories/flow_repository.dart';

import '../../core/constants.dart';
import '../../core/exceptions.dart';
import '../../domain/entities/flows/vote.dart';
import '../datasources/flow_data_source.dart';
import '../models/flow/post_model.dart';

class FlowRepositoryImpl implements FlowRepository {
  final FlowRemoteDataSource remoteDataSource;

  FlowRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Post>> addTextPost(String orgaId, String userId,
      TextContent text, String title, String flowId, bool isDraft) async {
    try {
      final result = await remoteDataSource.addTextPost(
          orgaId, userId, text, title, flowId, isDraft);

      return (Right(result.toEntity()));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, ModelContainer<Post>>> getApprovedPosts(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String searchText,
      Map<String, int> fieldsOrder,
      int pageIndex,
      int pageSize)async {

        try{
          final Map<String, dynamic> params = {};
          final resultModelContainer = await remoteDataSource.getPosts(
            orgaId, 
            userId, 
            flowId, 
            stageId, 
            searchText, 
            fieldsOrder, 
            pageIndex, 
            pageSize, 
            params,
            BoxPages.approvedPosts);

          List<Post> list = [];
         
          if (resultModelContainer.currentItemCount > 0) {
            for (var element in resultModelContainer.items) {
              list.add(element.toEntity());
            }
          }
          return Right(ModelContainer<Post>(
          list,
          resultModelContainer.currentItemCount,
          resultModelContainer.itemsPerPage,
          resultModelContainer.startIndex,
          resultModelContainer.totalItems,
          resultModelContainer.pageIndex,
          resultModelContainer.totalPages,
          resultModelContainer.kind));
        } on ServerException {
          return const Left(ServerFailure(''));
        } on SocketException {
          return const Left(ConnectionFailure('Failed to connect to the network'));
        }
      }

  @override
  Future<Either<Failure, ModelContainer<Post>>> getForApprovePosts(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String searchText,
      Map<String, int> fieldsOrder,
      int pageIndex,
      int pageSize) async{

        try{
          final Map<String, dynamic> params = {};
          final resultModelContainer = await remoteDataSource.getPosts(
            orgaId, 
            userId, 
            flowId, 
            stageId, 
            searchText, 
            fieldsOrder, 
            pageIndex, 
            pageSize, 
            params,
            BoxPages.forApprovePosts);

          List<Post> list = [];
         
          if (resultModelContainer.currentItemCount > 0) {
            for (var element in resultModelContainer.items) {
              list.add(element.toEntity());
            }
          }
          return Right(ModelContainer<Post>(
          list,
          resultModelContainer.currentItemCount,
          resultModelContainer.itemsPerPage,
          resultModelContainer.startIndex,
          resultModelContainer.totalItems,
          resultModelContainer.pageIndex,
          resultModelContainer.totalPages,
          resultModelContainer.kind));
        } on ServerException {
          return const Left(ServerFailure(''));
        } on SocketException {
          return const Left(ConnectionFailure('Failed to connect to the network'));
        }
      }

  @override
  Future<Either<Failure, ModelContainer<Post>>> getLatestPosts(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String searchText,
      int pageIndex,
      int pageSize)async {

        try{
          final Map<String, dynamic> params = {};
          final Map<String, int> fieldsOrder = {};
          final resultModelContainer = await remoteDataSource.getPosts(
            orgaId, 
            userId, 
            flowId, 
            stageId, 
            searchText, 
            fieldsOrder, 
            pageIndex, 
            pageSize, 
            params,
            BoxPages.latestPosts);

          List<Post> list = [];
         
          if (resultModelContainer.currentItemCount > 0) {
            for (var element in resultModelContainer.items) {
              list.add(element.toEntity());
            }
          }
          return Right(ModelContainer<Post>(
          list,
          resultModelContainer.currentItemCount,
          resultModelContainer.itemsPerPage,
          resultModelContainer.startIndex,
          resultModelContainer.totalItems,
          resultModelContainer.pageIndex,
          resultModelContainer.totalPages,
          resultModelContainer.kind));
        } on ServerException {
          return const Left(ServerFailure(''));
        } on SocketException {
          return const Left(ConnectionFailure('Failed to connect to the network'));
        }
      }

  @override
  Future<Either<Failure, ModelContainer<Post>>> getPopularPosts(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String searchText,
      int pageIndex,
      int pageSize) async{

        try{
          final Map<String, dynamic> params = {};
          final Map<String, int> fieldsOrder = {};
          final resultModelContainer = await remoteDataSource.getPosts(
            orgaId, 
            userId, 
            flowId, 
            stageId, 
            searchText, 
            fieldsOrder, 
            pageIndex, 
            pageSize, 
            params,
            BoxPages.popularPosts);

          List<Post> list = [];
         
          if (resultModelContainer.currentItemCount > 0) {
            for (var element in resultModelContainer.items) {
              list.add(element.toEntity());
            }
          }
          return Right(ModelContainer<Post>(
          list,
          resultModelContainer.currentItemCount,
          resultModelContainer.itemsPerPage,
          resultModelContainer.startIndex,
          resultModelContainer.totalItems,
          resultModelContainer.pageIndex,
          resultModelContainer.totalPages,
          resultModelContainer.kind));
        } on ServerException {
          return const Left(ServerFailure(''));
        } on SocketException {
          return const Left(ConnectionFailure('Failed to connect to the network'));
        }
      }

  @override
  Future<Either<Failure, ModelContainer<Post>>> getRejectedPosts(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String searchText,
      Map<String, int> fieldsOrder,
      int pageIndex,
      int pageSize) async{

        try{
          final Map<String, dynamic> params = {};
          final resultModelContainer = await remoteDataSource.getPosts(
            orgaId, 
            userId, 
            flowId, 
            stageId, 
            searchText, 
            fieldsOrder, 
            pageIndex, 
            pageSize, 
            params,
            BoxPages.rejectedPosts);

          List<Post> list = [];
         
          if (resultModelContainer.currentItemCount > 0) {
            for (var element in resultModelContainer.items) {
              list.add(element.toEntity());
            }
          }
          return Right(ModelContainer<Post>(
          list,
          resultModelContainer.currentItemCount,
          resultModelContainer.itemsPerPage,
          resultModelContainer.startIndex,
          resultModelContainer.totalItems,
          resultModelContainer.pageIndex,
          resultModelContainer.totalPages,
          resultModelContainer.kind));
        } on ServerException {
          return const Left(ServerFailure(''));
        } on SocketException {
          return const Left(ConnectionFailure('Failed to connect to the network'));
        }
      }

  @override
  Future<Either<Failure, ModelContainer<Post>>> getUploadedPosts(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      bool onlyDrafts,
      String searchText,
      Map<String, int> fieldsOrder,
      int pageIndex,
      int pageSize) async {
    try {
    //crear boxpage, y params
      final Map<String, dynamic> params = {'isdraft': onlyDrafts};

      final resultModelContainer = await remoteDataSource.getPosts(
          orgaId,
          userId,
          flowId,
          stageId,
          searchText,
          fieldsOrder,
          pageIndex,
          pageSize,
          params,
          BoxPages.uploadedPosts);

      List<Post> list = [];

      if (resultModelContainer.currentItemCount > 0) {
        for (var element in resultModelContainer.items) {
          list.add(element.toEntity());
        }
      }

      return Right(ModelContainer<Post>(
          list,
          resultModelContainer.currentItemCount,
          resultModelContainer.itemsPerPage,
          resultModelContainer.startIndex,
          resultModelContainer.totalItems,
          resultModelContainer.pageIndex,
          resultModelContainer.totalPages,
          resultModelContainer.kind));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, ModelContainer<Post>>> getVotedPosts(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String searchText,
      Map<String, int> fieldsOrder,
      int pageIndex,
      int pageSize,
      int voteState)async {
    try {
      
      final Map<String, dynamic> params = {'voteState': voteState};

      final resultModelContainer = await remoteDataSource.getPosts(
          orgaId,
          userId,
          flowId,
          stageId,
          searchText,
          fieldsOrder,
          pageIndex,
          pageSize,
          params,
          BoxPages.votedPosts);

      List<Post> list = [];

      if (resultModelContainer.currentItemCount > 0) {
        for (var element in resultModelContainer.items) {
          list.add(element.toEntity());
        }
      }

      return Right(ModelContainer<Post>(
          list,
          resultModelContainer.currentItemCount,
          resultModelContainer.itemsPerPage,
          resultModelContainer.startIndex,
          resultModelContainer.totalItems,
          resultModelContainer.pageIndex,
          resultModelContainer.totalPages,
          resultModelContainer.kind));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, ModelContainer<Vote>>> votePublication(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String postId,
      int voteValue) async{
    try {
      
      final resultModelContainer = await remoteDataSource.votePublication(
          orgaId,
          userId,
          flowId,
          stageId,
          postId,
          voteValue,
          );

      List<Vote> list = [];

      if (resultModelContainer.currentItemCount > 0) {
        for (var element in resultModelContainer.items) {
          list.add(element);
        }
      }

      return Right(ModelContainer<Vote>(
          list,
          resultModelContainer.currentItemCount,
          resultModelContainer.itemsPerPage,
          resultModelContainer.startIndex,
          resultModelContainer.totalItems,
          resultModelContainer.pageIndex,
          resultModelContainer.totalPages,
          resultModelContainer.kind));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
