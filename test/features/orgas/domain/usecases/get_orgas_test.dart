import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lomba_frontend/features/orgas/domain/entities/orga.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/get_orgas.dart';
import 'package:mockito/mockito.dart';

import 'orga_repository_helper.mocks.dart';

void main() {
  late MockOrgaRepository mockOrgaRepository;
  late GetOrgas usecase;

  setUp(() {
    mockOrgaRepository = MockOrgaRepository();
    usecase = GetOrgas(mockOrgaRepository);
  });

  final newOrgaId = Guid.newGuid.toString();

  final tOrga = Orga(
      id: newOrgaId,
      name: 'Test Orga',
      code: 'test',
      enabled: true,
      builtIn: false);

  test('debe conseguir lista de orgas', () async {
    //arrange
    when(mockOrgaRepository.getOrgas(any, any, any, any))
        .thenAnswer((_) async => Right(<Orga>[tOrga]));

    //act
    final result = await usecase.execute("", "", 1, 10);
    List<Orga> list = [];

    result.fold((l) => {}, (r) => {list = r});

    //assert
    expect(list, <Orga>[tOrga]);
  });
}
