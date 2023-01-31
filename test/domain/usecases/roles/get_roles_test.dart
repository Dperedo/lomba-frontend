import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/domain/entities/role.dart';
import 'package:lomba_frontend/domain/usecases/roles/get_roles.dart';
import 'package:mockito/mockito.dart';

import 'role_test_helper.mocks.dart';

void main() {
  late MockRoleRepository mockRoleRepository;
  late GetRoles usecase;

  setUp(() {
    mockRoleRepository = MockRoleRepository();
    usecase = GetRoles(mockRoleRepository);
  });

  const tRole = Role(
    name: 'Test Role',
    enabled: true,
  );

  test('debe conseguir lista de roles', () async {
    //arrange
    when(mockRoleRepository.getRoles())
        .thenAnswer((_) async => const Right(<Role>[tRole]));

    //act
    final result = await usecase.execute();
    List<Role> list = [];

    result.fold((l) => {}, (r) => {list = r});

    //assert
    expect(list, <Role>[tRole]);
  });
}
