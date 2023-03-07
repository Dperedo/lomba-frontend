import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../core/exceptions.dart';
import '../../domain/entities/workflow/flow.dart';
import '../../domain/repositories/flow_repository.dart';
import '../datasources/flow_data_source.dart';

class FlowRepositoryImpl implements FlowRepository {
  final FlowRemoteDataSource remoteDataSource;

  FlowRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Flow>>> getFlows() async {
    try {
      final result = await remoteDataSource.getFlows();

      List<Flow> list = [];

      if (result.isNotEmpty) {
        for (var element in result) {
          list.add(element.toEntity());
        }
      }

      return Right(list);
    } on ServerException {
      return const Left(ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, Flow>> getFlow(String flowId) async {
    try {
      final result = await remoteDataSource.getFlow(flowId);

      return (Right(result.toEntity()));
    } on ServerException {
      return const Left(ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  
}
