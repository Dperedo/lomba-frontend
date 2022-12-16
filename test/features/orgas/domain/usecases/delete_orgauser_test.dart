import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/delete_orgauser.dart';
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
