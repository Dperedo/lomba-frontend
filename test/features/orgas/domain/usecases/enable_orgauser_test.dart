import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/features/orgas/domain/entities/orga.dart';
import 'package:lomba_frontend/features/orgas/domain/entities/orgauser.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/enable_orgauser.dart';
import 'package:mockito/mockito.dart';

import 'orga_repository_helper.mocks.dart';

void main() {
  late MockOrgaRepository mockOrgaRepository;
  late EnableOrgaUser usecase;

  setUp(() {
    mockOrgaRepository = MockOrgaRepository();
    usecase = EnableOrgaUser(mockOrgaRepository);
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

  test('debe deshabilitar un orgauser (relación entre ellos)', () async {
    //arrange
    when(mockOrgaRepository.enableOrgaUser(any, any, any))
        .thenAnswer((_) async => const Right(true));

    //act
    final result = await usecase.execute(newOrgaId, newUserId, false);

    //assert
    expect(result, const Right(true));
  });
}
