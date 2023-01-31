import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/domain/entities/role.dart';
import 'package:lomba_frontend/domain/usecases/roles/enable_role.dart';
import 'package:mockito/mockito.dart';

import 'role_test_helper.mocks.dart';

void main() {
  late MockRoleRepository mockRoleRepository;
  late EnableRole usecase;

  setUp(() {
    mockRoleRepository = MockRoleRepository();
    usecase = EnableRole(mockRoleRepository);
  });

  final newRoleName = Guid.newGuid.toString();

  const tRole = Role(
    name: 'Test Role',
    enabled: true,
  );

  test('debe deshabilitar un rol', () async {
    //arrange
    when(mockRoleRepository.enableRole(any, any))
        .thenAnswer((_) async => const Right(tRole));

    //act
    final result = await usecase.execute(newRoleName, false);

    //assert
    expect(result, const Right(tRole));
  });
}
