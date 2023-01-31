import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/domain/entities/role.dart';
import 'package:lomba_frontend/domain/usecases/roles/get_role.dart';
import 'package:mockito/mockito.dart';

import 'role_test_helper.mocks.dart';

void main() {
  late MockRoleRepository mockRoleRepository;
  late GetRole usecase;

  setUp(() {
    mockRoleRepository = MockRoleRepository();
    usecase = GetRole(mockRoleRepository);
  });

  final newRoleId = Guid.newGuid.toString();

  const Role tRole = Role(
    name: 'Test Role',
    enabled: true,
  );

  test('debe conserguir un rol', () async {
    //arrange
    when(mockRoleRepository.getRole(any))
        .thenAnswer((_) async => const Right(tRole));

    //act
    final result = await usecase.execute(newRoleId);

    //assert
    expect(result, const Right(tRole));
  });
}
