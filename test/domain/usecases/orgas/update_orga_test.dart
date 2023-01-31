import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/domain/entities/orga.dart';
import 'package:lomba_frontend/domain/usecases/orgas/update_orga.dart';
import 'package:mockito/mockito.dart';

import 'orga_repository_helper.mocks.dart';

void main() {
  late MockOrgaRepository mockOrgaRepository;
  late UpdateOrga usecase;

  setUp(() {
    mockOrgaRepository = MockOrgaRepository();
    usecase = UpdateOrga(mockOrgaRepository);
  });

  final newOrgaId = Guid.newGuid.toString();

  final tOrga = Orga(
      id: newOrgaId,
      name: 'Test Orga',
      code: 'test',
      enabled: true,
      builtIn: false);

  test('debe actualizar un nuevo orga', () async {
    //arrange
    when(mockOrgaRepository.updateOrga(any, any))
        .thenAnswer((_) async => Right(tOrga));

    //act
    final result = await usecase.execute(newOrgaId, tOrga);

    //assert
    expect(result, Right(tOrga));
  });
}
