import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';
import 'package:lomba_frontend/core/model_container.dart';
import 'package:lomba_frontend/domain/entities/workflow/post.dart';
import 'package:lomba_frontend/domain/entities/workflow/textcontent.dart';
import 'package:lomba_frontend/domain/repositories/post_repository.dart';

import '../../core/constants.dart';
import '../../core/exceptions.dart';
import '../../domain/entities/workflow/imagecontent.dart';
import '../../domain/entities/workflow/videocontent.dart';
import '../../domain/entities/workflow/vote.dart';
import '../datasources/post_data_source.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Post>> addTextPost(String orgaId, String userId,
      TextContent text, String title, String flowId, bool isDraft) async {
    try {
      final result = await remoteDataSource.addTextPost(
          orgaId, userId, text, title, flowId, isDraft);

      return (Right(result.toEntity()));
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, Post>> addMultiPost(
      String orgaId,
      String userId,
      TextContent? text,
      ImageContent? image,
      VideoContent? video,
      String title,
      String flowId,
      bool isDraft) async {
    try {
      final result = await remoteDataSource.addMultiPost(
          orgaId, userId, text, image, video, title, flowId, isDraft);

      return (Right(result.toEntity()));
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, Post>> updatePost(
      String postId, String userId, TextContent text, String title) async {
    try {
      final result =
          await remoteDataSource.updatePost(postId, userId, text, title);

      return (Right(result.toEntity()));
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, Post>> deletePost(String postId, String userId) async {
    try {
      final result = await remoteDataSource.deletePost(postId, userId);

      return (Right(result.toEntity()));
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, Post>> changeStagePost(
    String postId,
    String flowId,
    String stageId,
  ) async {
    try {
      final result =
          await remoteDataSource.changeStagePost(postId, flowId, stageId);

      return (Right(result.toEntity()));
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, Post>> enablePost(
      String postId, bool enableOrDisable) async {
    try {
      final result = await remoteDataSource.enablePost(postId, enableOrDisable);

      if (result) {
        final resultItem = await remoteDataSource.getPost(postId);
        return Right(resultItem.toEntity());
      }
      return const Left(ServerFailure('No fue posible realizar la acción'));
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, Post>> getPost(String postId) async {
    try {
      final result = await remoteDataSource.getPost(postId);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, Post>> getPostWithUser(
      String postId, String userId, String flowId, String stageId) async {
    try {
      final result = await remoteDataSource.getPostWithUser(
          postId, userId, flowId, stageId);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
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
      int pageSize) async {
    try {
      final Map<String, dynamic> params = {};
      List<dynamic> order = [];
      fieldsOrder.forEach((key, value) {
        order.add([key, value == 1 ? value : -1]);
      });
      final resultModelContainer = await remoteDataSource.getPosts(
          orgaId,
          userId,
          flowId,
          stageId,
          searchText,
          order,
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
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
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
      int pageSize) async {
    try {
      final Map<String, dynamic> params = {};
      List<dynamic> order = [];
      fieldsOrder.forEach((key, value) {
        order.add([key, value == 1 ? value : -1]);
      });
      final resultModelContainer = await remoteDataSource.getPosts(
          orgaId,
          userId,
          flowId,
          stageId,
          searchText,
          order,
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
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
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
      int pageSize) async {
    try {
      final Map<String, dynamic> params = {};
      List<dynamic> order = [];

      final resultModelContainer = await remoteDataSource.getPosts(
          orgaId,
          userId,
          flowId,
          stageId,
          searchText,
          order,
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
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
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
      int pageSize) async {
    try {
      final Map<String, dynamic> params = {};
      final List<dynamic> order = [];

      final resultModelContainer = await remoteDataSource.getPosts(
          orgaId,
          userId,
          flowId,
          stageId,
          searchText,
          order,
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
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
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
      int pageSize) async {
    try {
      final Map<String, dynamic> params = {};
      List<dynamic> order = [];
      fieldsOrder.forEach((key, value) {
        order.add([key, value == 1 ? value : -1]);
      });
      final resultModelContainer = await remoteDataSource.getPosts(
          orgaId,
          userId,
          flowId,
          stageId,
          searchText,
          order,
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
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
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

      List<dynamic> order = [];
      fieldsOrder.forEach((key, value) {
        order.add([key, value == 1 ? value : -1]);
      });

      final resultModelContainer = await remoteDataSource.getPosts(
          orgaId,
          userId,
          flowId,
          stageId,
          searchText,
          order,
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
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
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
      int voteState) async {
    try {
      final Map<String, dynamic> params = {'voteState': voteState};
      List<dynamic> order = [];
      fieldsOrder.forEach((key, value) {
        order.add([key, value == 1 ? value : -1]);
      });
      final resultModelContainer = await remoteDataSource.getPosts(
          orgaId,
          userId,
          flowId,
          stageId,
          searchText,
          order,
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
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, ModelContainer<Post>>> getFavoritesPosts(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String searchText,
      Map<String, int> fieldsOrder,
      int pageIndex,
      int pageSize,
      int voteState) async {
    try {
      final Map<String, dynamic> params = {'voteState': voteState};
      List<dynamic> order = [];
      fieldsOrder.forEach((key, value) {
        order.add([key, value == 1 ? value : -1]);
      });
      final resultModelContainer = await remoteDataSource.getPosts(
          orgaId,
          userId,
          flowId,
          stageId,
          searchText,
          order,
          pageIndex,
          pageSize,
          params,
          BoxPages.favoritesPosts);

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
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, ModelContainer<Post>>> getSavedPosts(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String searchText,
      Map<String, int> fieldsOrder,
      int pageIndex,
      int pageSize,
      int voteState) async {
    try {
      final Map<String, dynamic> params = {'voteState': voteState};
      List<dynamic> order = [];
      fieldsOrder.forEach((key, value) {
        order.add([key, value == 1 ? value : -1]);
      });
      final resultModelContainer = await remoteDataSource.getPosts(
          orgaId,
          userId,
          flowId,
          stageId,
          searchText,
          order,
          pageIndex,
          pageSize,
          params,
          BoxPages.savedPosts);

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
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, ModelContainer<Vote>>> votePublication(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String postId,
      int voteValue) async {
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
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, ModelContainer<Post>>> getDetailedListPosts(
      String orgaId,
      String userId,
      String flowId,
      String stageId,
      String searchText,
      Map<String, int> fieldsOrder,
      int pageIndex,
      int pageSize,
      int enableValue) async {
    try {
      final Map<String, dynamic> params = {'postEnabled': enableValue};
      List<dynamic> order = [];

      final resultModelContainer = await remoteDataSource.getAdminViewPosts(
          orgaId,
          userId,
          flowId,
          stageId,
          searchText,
          order,
          pageIndex,
          pageSize,
          params);

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
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }
}
