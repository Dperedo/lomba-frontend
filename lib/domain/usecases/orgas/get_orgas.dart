import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../entities/orga.dart';
import '../../repositories/orga_repository.dart';

///Caso de uso para obtener una lista de organizaciones
class GetOrgas {
  final OrgaRepository repository;
  GetOrgas(this.repository);

  ///[filter] es el filtro de búsqueda. Debe ser vacío para no considerar.
  ///[fieldOrder] especifica el campo por el cual se ordenará la lista (ASC)
  ///[pageNumber] el número de página de la lista paginada.
  ///[pageSize] es el tamaño de las páginas de la lista paginada
  Future<Either<Failure, List<Orga>>> execute(
      String filter, String fieldOrder, double pageNumber, int pageSize) async {
    return await repository.getOrgas(filter, fieldOrder, pageNumber, pageSize);
  }
}
