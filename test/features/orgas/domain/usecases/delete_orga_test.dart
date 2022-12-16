import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/delete_orga.dart';
import 'package:mockito/mockito.dart';

import 'orga_repository_helper.mocks.dart';

void main() {
  late MockOrgaRepository mockOrgaRepository;
  late DeleteOrga usecase;

  setUp(() {
    mockOrgaRepository = MockOrgaRepository();
    usecase = DeleteOrga(mockOrgaRepository);
  });

  final newOrgaId = Guid.newGuid.toString();

  test('debe eliminar un nuevo orga', () async {
    //arrange
    when(mockOrgaRepository.deleteOrga(any))
        .thenAnswer((_) async => const Right(true));

    //act
    final result = await usecase.execute(newOrgaId);

    //assert
    expect(result, const Right(true));
  });
}
