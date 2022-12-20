import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/features/orgas/domain/entities/orgauser.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/add_orgauser.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/delete_orgauser.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/enable_orgauser.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/get_orgausers.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/update_orgauser.dart';
import 'package:lomba_frontend/features/orgas/presentation/bloc/orgauser_bloc.dart';
import 'package:lomba_frontend/features/orgas/presentation/bloc/orgauser_event.dart';
import 'package:lomba_frontend/features/orgas/presentation/bloc/orgauser_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'orgauser_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AddOrgaUser>(),
  MockSpec<DeleteOrgaUser>(),
  MockSpec<EnableOrgaUser>(),
  MockSpec<GetOrgaUsers>(),
  MockSpec<UpdateOrgaUser>(),
])
Future<void> main() async {
  late AddOrgaUser mockAddOrgaUser;
  late DeleteOrgaUser mockDeleteOrgaUser;
  late EnableOrgaUser mockEnableOrgaUser;
  late GetOrgaUsers mockGetOrgaUsers;
  late UpdateOrgaUser mockUpdateOrgaUser;

  late OrgaUserBloc orgaUserBloc;

  setUp(() {
    mockAddOrgaUser = MockAddOrgaUser();
    mockDeleteOrgaUser = MockDeleteOrgaUser();
    mockEnableOrgaUser = MockEnableOrgaUser();
    mockGetOrgaUsers = MockGetOrgaUsers();
    mockUpdateOrgaUser = MockUpdateOrgaUser();

    orgaUserBloc = OrgaUserBloc(mockAddOrgaUser, mockDeleteOrgaUser,
        mockEnableOrgaUser, mockGetOrgaUsers, mockUpdateOrgaUser);
  });

  final newOrgaId = Guid.newGuid.toString();
  final newUserId = Guid.newGuid.toString();

  final tOrgaUser = OrgaUser(
      userId: newUserId,
      orgaId: newOrgaId,
      roles: const <String>[Roles.roleAdmin],
      enabled: true,
      builtIn: false);

  test(
    'el estado inicial debe ser Start',
    () {
      expect(orgaUserBloc.state, OrgaUserStart());
    },
  );

  group('conseguir organizaciones y orgausers', () {
    blocTest<OrgaUserBloc, OrgaUserState>(
      'debe lanzar el spinner y devolver estado con listado de orgausers',
      build: () {
        when(mockGetOrgaUsers.execute(newOrgaId))
            .thenAnswer((_) async => Right(<OrgaUser>[tOrgaUser]));
        return orgaUserBloc;
      },
      act: (bloc) => bloc.add(OnOrgaUserListLoad(newOrgaId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        OrgaUserLoading(),
        OrgaUserListLoaded(<OrgaUser>[tOrgaUser]),
      ],
      verify: (bloc) {
        verify(mockGetOrgaUsers.execute(newOrgaId));
      },
    );
  });

  group('agregar organizaciones y orgausers', () {
    blocTest<OrgaUserBloc, OrgaUserState>(
      'debe agregar un orgauser',
      build: () {
        when(mockAddOrgaUser.execute(tOrgaUser.orgaId, tOrgaUser.userId,
                tOrgaUser.roles, tOrgaUser.enabled))
            .thenAnswer((_) async => Right(tOrgaUser));
        return orgaUserBloc;
      },
      act: (bloc) => bloc.add(OnOrgaUserAdd(tOrgaUser.orgaId, tOrgaUser.userId,
          tOrgaUser.roles, tOrgaUser.enabled)),
      wait: const Duration(milliseconds: 500),
      expect: () => [OrgaUserLoading(), OrgaUserStart()],
      verify: (bloc) {
        verify(mockAddOrgaUser.execute(tOrgaUser.orgaId, tOrgaUser.userId,
            tOrgaUser.roles, tOrgaUser.enabled));
      },
    );
  });

  group('eliminar orgas y orgausers', () {
    blocTest<OrgaUserBloc, OrgaUserState>(
      'debe eliminar un orgauser',
      build: () {
        when(mockDeleteOrgaUser.execute(newOrgaId, newUserId))
            .thenAnswer((_) async => const Right(true));
        return orgaUserBloc;
      },
      act: (bloc) => bloc.add(OnOrgaUserDelete(newOrgaId, newUserId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [OrgaUserLoading(), OrgaUserStart()],
      verify: (bloc) {
        verify(mockDeleteOrgaUser.execute(newOrgaId, newUserId));
      },
    );
  });
  group('deshabilitar orgas y orgausers', () {
    blocTest<OrgaUserBloc, OrgaUserState>(
      'debe deshabilitar un orgauser',
      build: () {
        when(mockEnableOrgaUser.execute(newOrgaId, newUserId, false))
            .thenAnswer((_) async => Right(tOrgaUser));
        return orgaUserBloc;
      },
      act: (bloc) => bloc.add(OnOrgaUserEnable(newOrgaId, newUserId, false)),
      wait: const Duration(milliseconds: 500),
      expect: () => [OrgaUserLoading(), OrgaUserStart()],
      verify: (bloc) {
        verify(mockEnableOrgaUser.execute(newOrgaId, newUserId, false));
      },
    );
  });
  group('actualizar orgas y orgausers', () {
    blocTest<OrgaUserBloc, OrgaUserState>(
      'debe actualizar un orgauser',
      build: () {
        when(mockUpdateOrgaUser.execute(
                tOrgaUser.orgaId, tOrgaUser.userId, tOrgaUser))
            .thenAnswer((_) async => Right(tOrgaUser));
        return orgaUserBloc;
      },
      act: (bloc) => bloc.add(OnOrgaUserEdit(tOrgaUser.orgaId, tOrgaUser.userId,
          tOrgaUser.roles, tOrgaUser.enabled)),
      wait: const Duration(milliseconds: 500),
      expect: () => [OrgaUserLoading(), OrgaUserStart()],
      verify: (bloc) {
        verify(mockUpdateOrgaUser.execute(
            tOrgaUser.orgaId, tOrgaUser.userId, tOrgaUser));
      },
    );
  });
}