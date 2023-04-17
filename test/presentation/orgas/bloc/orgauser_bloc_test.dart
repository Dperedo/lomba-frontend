import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/core/failures.dart';
import 'package:lomba_frontend/core/model_container.dart';
import 'package:lomba_frontend/data/models/sort_model.dart';
import 'package:lomba_frontend/domain/entities/orgauser.dart';
import 'package:lomba_frontend/domain/usecases/orgas/add_orgauser.dart';
import 'package:lomba_frontend/domain/usecases/orgas/delete_orgauser.dart';
import 'package:lomba_frontend/domain/usecases/orgas/enable_orgauser.dart';
import 'package:lomba_frontend/domain/usecases/orgas/get_orgausers.dart';
import 'package:lomba_frontend/domain/usecases/orgas/update_orgauser.dart';
import 'package:lomba_frontend/presentation/orgas/bloc/orgauser_bloc.dart';
import 'package:lomba_frontend/presentation/orgas/bloc/orgauser_event.dart';
import 'package:lomba_frontend/presentation/orgas/bloc/orgauser_state.dart';
import 'package:lomba_frontend/domain/entities/user.dart';
import 'package:lomba_frontend/domain/usecases/users/get_users.dart';
import 'package:lomba_frontend/domain/usecases/users/get_users_notin_orga.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'orgauser_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AddOrgaUser>(),
  MockSpec<DeleteOrgaUser>(),
  MockSpec<EnableOrgaUser>(),
  MockSpec<GetOrgaUsers>(),
  MockSpec<UpdateOrgaUser>(),
  MockSpec<GetUsers>(),
  MockSpec<GetUsersNotInOrga>()
])
Future<void> main() async {
  late AddOrgaUser mockAddOrgaUser;
  late DeleteOrgaUser mockDeleteOrgaUser;
  late EnableOrgaUser mockEnableOrgaUser;
  late GetOrgaUsers mockGetOrgaUsers;
  late UpdateOrgaUser mockUpdateOrgaUser;
  late GetUsers mockGetUsers;
  late GetUsersNotInOrga mockOrgaUsersNotInOrga;

  late OrgaUserBloc orgaUserBloc;

  setUp(() {
    mockAddOrgaUser = MockAddOrgaUser();
    mockDeleteOrgaUser = MockDeleteOrgaUser();
    mockEnableOrgaUser = MockEnableOrgaUser();
    mockGetOrgaUsers = MockGetOrgaUsers();
    mockUpdateOrgaUser = MockUpdateOrgaUser();
    mockGetUsers = MockGetUsers();
    mockOrgaUsersNotInOrga = MockGetUsersNotInOrga();

    orgaUserBloc = OrgaUserBloc(
        mockAddOrgaUser,
        mockDeleteOrgaUser,
        mockEnableOrgaUser,
        mockGetOrgaUsers,
        mockUpdateOrgaUser,
        mockGetUsers,
        mockOrgaUsersNotInOrga);
  });

  final newOrgaId = Guid.newGuid.toString();
  final newUserId = Guid.newGuid.toString();

  const List<User> test_listUser = [];
  const String test_orgaId = "00000200-0200-0200-0200-000000000200";
  const int test_pageIndex = 1;
  const int test_pageSize = 10;

  final tOrgaUser = OrgaUser(
      userId: newUserId,
      orgaId: newOrgaId,
      roles: const <String>[Roles.roleAdmin],
      enabled: true,
      builtIn: false);

  final tUser = User(
      id: newUserId,
      name: 'Test User',
      username: 'test',
      email: 'te@mp.com',
      enabled: true,
      builtIn: false);

  test(
    'el estado inicial debe ser Start',
    () {
      expect(orgaUserBloc.state, const OrgaUserStart(""));
    },
  );

  group('conseguir organizaciones y orgausers', () {
    blocTest<OrgaUserBloc, OrgaUserState>(
      'debe lanzar el spinner y devolver estado con listado de orgausers',
      build: () {
        when(mockGetOrgaUsers.execute(newOrgaId))
            .thenAnswer((_) async => Right(<OrgaUser>[tOrgaUser]));

        when(mockGetUsers.execute(
                "", newOrgaId, <String, int>{"email": 1}, 1, 10))
            .thenAnswer((realInvocation) async =>
                Right(ModelContainer.fromItem(tUser)));
        return orgaUserBloc;
      },
      act: (bloc) => bloc.add(OnOrgaUserListLoad(
          '', newOrgaId, const <String, int>{"email": 1}, 1, 10)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        OrgaUserLoading(),
        OrgaUserListLoaded(newOrgaId, <User>[tUser], <OrgaUser>[tOrgaUser], '',
            const <String, int>{"email": 1}, 1, 10, 1, 0, 1),
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
          tOrgaUser.roles, tOrgaUser.enabled, 'user')),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        OrgaUserLoading(),
        const OrgaUserStart(" El usuario user fue agregado a la organización")
      ],
      verify: (bloc) {
        verify(mockAddOrgaUser.execute(tOrgaUser.orgaId, tOrgaUser.userId,
            tOrgaUser.roles, tOrgaUser.enabled));
      },
    );

    blocTest<OrgaUserBloc, OrgaUserState>(
      'debe agregar un orgauser y emitir error al agregar',
      build: () {
        when(mockAddOrgaUser.execute(tOrgaUser.orgaId, tOrgaUser.userId,
                tOrgaUser.roles, tOrgaUser.enabled))
            .thenAnswer((_) async => const Left(ConnectionFailure('error')));
        return orgaUserBloc;
      },
      act: (bloc) => bloc.add(OnOrgaUserAdd(tOrgaUser.orgaId, tOrgaUser.userId,
          tOrgaUser.roles, tOrgaUser.enabled, 'user')),
      wait: const Duration(milliseconds: 500),
      expect: () => [OrgaUserLoading(), const OrgaUserError('error')],
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
      act: (bloc) => bloc.add(OnOrgaUserDelete(newOrgaId, newUserId, 'user')),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        OrgaUserLoading(),
        const OrgaUserStart(
            " El Usuario user fue desasociado de la organización")
      ],
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
      expect: () => [OrgaUserLoading(), const OrgaUserStart("")],
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
        when(mockGetUsers.execute(
                "", newOrgaId, <String, int>{"email": 1}, 1, 10))
            .thenAnswer((realInvocation) async =>
                Right(ModelContainer.fromItem(tUser)));
        when(mockGetOrgaUsers.execute(newOrgaId))
            .thenAnswer((realInvocation) async => Right(<OrgaUser>[tOrgaUser]));
        return orgaUserBloc;
      },
      act: (bloc) => bloc.add(OnOrgaUserEdit(tOrgaUser.orgaId, tOrgaUser.userId,
          tOrgaUser.roles, tOrgaUser.enabled)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        OrgaUserLoading(),
        OrgaUserListLoaded(newOrgaId, <User>[tUser], <OrgaUser>[tOrgaUser], '',
            const <String, int>{"email": 1}, 1, 10, 1, 0, 1),
      ],
      verify: (bloc) {
        verify(mockUpdateOrgaUser.execute(
            tOrgaUser.orgaId, tOrgaUser.userId, tOrgaUser));
      },
    );
  });

  group('lista orgausers', () {
    blocTest<OrgaUserBloc, OrgaUserState>(
      'debe mostrar lista de user que no pertenezcan al orga',
      build: () {
        when(mockOrgaUsersNotInOrga.execute('', test_orgaId,
                <String, int>{"email": 1}, test_pageIndex, test_pageSize))
            .thenAnswer((realInvocation) async =>
                Right(ModelContainer.fromItems(test_listUser)));
        return orgaUserBloc;
      },
      act: (bloc) => bloc.add(const OnOrgaUserListUserNotInOrgaForAdd(
          '',
          test_orgaId,
          <String, int>{"email": 1},
          test_pageIndex,
          test_pageSize)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        OrgaUserLoading(),
        const OrgaUserListUserNotInOrgaLoaded(test_orgaId, test_listUser, '',
            <String, int>{"email": 1}, test_pageIndex, test_pageSize, 0, 0, 1)
      ],
      verify: (bloc) {
        verify(mockOrgaUsersNotInOrga.execute('', test_orgaId,
            <String, int>{"email": 1}, test_pageIndex, test_pageSize));
      },
    );
  });
}
