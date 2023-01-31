import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/domain/entities/role.dart';
import 'package:lomba_frontend/domain/usecases/roles/enable_role.dart';
import 'package:lomba_frontend/domain/usecases/roles/get_role.dart';
import 'package:lomba_frontend/domain/usecases/roles/get_roles.dart';
import 'package:lomba_frontend/presentation/roles/bloc/role_bloc.dart';
import 'package:lomba_frontend/presentation/roles/bloc/role_event.dart';
import 'package:lomba_frontend/presentation/roles/bloc/role_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'role_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<EnableRole>(),
  MockSpec<GetRole>(),
  MockSpec<GetRoles>(),
])
Future<void> main() async {
  late EnableRole mockEnableRole;
  late GetRole mockGetRole;
  late GetRoles mockGetRoles;

  late RoleBloc roleBloc;

  setUp(() {
    mockEnableRole = MockEnableRole();
    mockGetRole = MockGetRole();
    mockGetRoles = MockGetRoles();

    roleBloc = RoleBloc(
      mockEnableRole,
      mockGetRole,
      mockGetRoles,
    );
  });

  final newRoleName = Guid.newGuid.toString();

  const tRole = Role(
    name: 'Test Role',
    enabled: true,
  );

  test(
    'el estado inicial debe ser Start',
    () {
      //assert
      expect(roleBloc.state, RoleStart());
    },
  );

  group('conseguir rolenizaciones y roleroles', () {
    blocTest<RoleBloc, RoleState>(
      'debe lanzar el spinner y devolver estado con listado',
      build: () {
        when(mockGetRoles.execute())
            .thenAnswer((_) async => const Right(<Role>[tRole]));
        return roleBloc;
      },
      act: (bloc) => bloc.add(const OnRoleListLoad()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        RoleLoading(),
        const RoleListLoaded(<Role>[tRole]),
      ],
      verify: (bloc) {
        verify(mockGetRoles.execute());
      },
    );

    blocTest<RoleBloc, RoleState>(
      'debe lanzar el spinner y devolver estado con el rol',
      build: () {
        when(mockGetRole.execute(newRoleName))
            .thenAnswer((_) async => const Right(tRole));
        return roleBloc;
      },
      act: (bloc) => bloc.add(OnRoleLoad(newRoleName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        RoleLoading(),
        const RoleLoaded(tRole),
      ],
      verify: (bloc) {
        verify(mockGetRole.execute(newRoleName));
      },
    );
  });

  group('deshabilitar roles y roleroles', () {
    blocTest<RoleBloc, RoleState>(
      'debe deshabilitar un role',
      build: () {
        when(mockEnableRole.execute(newRoleName, false))
            .thenAnswer((_) async => const Right(tRole));
        return roleBloc;
      },
      act: (bloc) => bloc.add(OnRoleEnable(newRoleName, false)),
      wait: const Duration(milliseconds: 500),
      expect: () => [RoleLoading(), const RoleLoaded(tRole)],
      verify: (bloc) {
        verify(mockEnableRole.execute(newRoleName, false));
      },
    );
  });
}
