import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/features/orgas/data/models/orga_model.dart';
import 'package:lomba_frontend/features/orgas/domain/entities/orga.dart';
import 'package:lomba_frontend/features/orgas/domain/entities/orgauser.dart';
import 'package:lomba_frontend/features/orgas/domain/repositories/orga_repository.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/add_orga.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/add_orgauser.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/delete_orgauser.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'orga_repository_helper.mocks.dart';

void main() {
  late MockOrgaRepository mockOrgaRepository;
  late DeleteOrgaUser usecase;

  setUp(() {
    mockOrgaRepository = MockOrgaRepository();
    usecase = DeleteOrgaUser(mockOrgaRepository);
  });

  final newOrgaId = Guid.newGuid.toString();
  final newUserId = Guid.newGuid.toString();

  final tOrgaUser = OrgaUser(
      userId: newUserId,
      orgaId: newOrgaId,
      roles: const <String>[Roles.Admin],
      enabled: true,
      builtIn: true);

  final tOrga = Orga(
      id: newOrgaId,
      name: 'Test Orga',
      code: 'test',
      enabled: true,
      builtIn: false);

  test('debe eliminar un orgauser (relación entre ellos)', () async {
    //arrange
    when(mockOrgaRepository.deleteOrgaUser(any, any))
        .thenAnswer((_) async => const Right(true));

    //act
    final result = await usecase.execute(newOrgaId, newUserId);

    //assert
    expect(result, const Right(true));
  });
}
