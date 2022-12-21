import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';
import 'package:lomba_frontend/features/orgas/domain/entities/orga.dart';

import '../repositories/orga_repository.dart';

///Caso de uso para agregar una nueva organización
///
///Se encarga de agregar una organización y devolver el [Orga] nuevo.
///Debe especificar el nombre de la organización [name], el código único [code]
///e indicar is la organización está habilitada o no [enabled].
class AddOrga {
  final OrgaRepository repository;
  AddOrga(this.repository);
  Future<Either<Failure, Orga>> execute(
      String name, String code, bool enabled) async {
    return await repository.addOrga(name, code, enabled);
  }
}
