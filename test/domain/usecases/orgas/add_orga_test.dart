import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/domain/entities/orga.dart';
import 'package:lomba_frontend/domain/usecases/orgas/add_orga.dart';
import 'package:mockito/mockito.dart';

import 'orga_repository_helper.mocks.dart';

void main() {
  late MockOrgaRepository mockOrgaRepository;
  late AddOrga usecase;

  setUp(() {
    mockOrgaRepository = MockOrgaRepository();
    usecase = AddOrga(mockOrgaRepository);
  });

  final newOrgaId = Guid.newGuid.toString();

  final tOrga = Orga(
      id: newOrgaId,
      name: 'Test Orga',
      code: 'test',
      enabled: true,
      builtIn: false);

  test('debe agregar un nuevo orga', () async {
    //arrange
    when(mockOrgaRepository.addOrga(any, any, any))
        .thenAnswer((_) async => Right(tOrga));

    //act
    final result = await usecase.execute(tOrga.name, tOrga.code, tOrga.enabled);

    //assert
    expect(result, Right(tOrga));
  });
}
