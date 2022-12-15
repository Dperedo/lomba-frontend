import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/features/orgas/domain/entities/orga.dart';
import 'package:lomba_frontend/features/orgas/domain/entities/orgauser.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/add_orga.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/add_orgauser.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/delete_orga.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/delete_orgauser.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/enable_orga.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/enable_orgauser.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/get_orga.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/get_orgas.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/get_orgausers.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/update_orga.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/update_orgauser.dart';
import 'package:lomba_frontend/features/orgas/presentation/bloc/orga_bloc.dart';
import 'package:lomba_frontend/features/orgas/presentation/bloc/orga_event.dart';
import 'package:lomba_frontend/features/orgas/presentation/bloc/orga_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'orga_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AddOrga>(),
  MockSpec<AddOrgaUser>(),
  MockSpec<DeleteOrga>(),
  MockSpec<DeleteOrgaUser>(),
  MockSpec<EnableOrga>(),
  MockSpec<EnableOrgaUser>(),
  MockSpec<GetOrga>(),
  MockSpec<GetOrgas>(),
  MockSpec<GetOrgaUsers>(),
  MockSpec<UpdateOrga>(),
  MockSpec<UpdateOrgaUser>(),
])
Future<void> main() async {
  late AddOrga mockAddOrga;
  late AddOrgaUser mockAddOrgaUser;
  late DeleteOrga mockDeleteOrga;
  late DeleteOrgaUser mockDeleteOrgaUser;
  late EnableOrga mockEnableOrga;
  late EnableOrgaUser mockEnableOrgaUser;
  late GetOrga mockGetOrga;
  late GetOrgas mockGetOrgas;
  late GetOrgaUsers mockGetOrgaUsers;
  late UpdateOrga mockUpdateOrga;
  late UpdateOrgaUser mockUpdateOrgaUser;

  late OrgaBloc orgaBloc;

  setUp(() {
    mockAddOrga = MockAddOrga();
    mockAddOrgaUser = MockAddOrgaUser();
    mockDeleteOrga = MockDeleteOrga();
    mockDeleteOrgaUser = MockDeleteOrgaUser();
    mockEnableOrga = MockEnableOrga();
    mockEnableOrgaUser = MockEnableOrgaUser();
    mockGetOrga = MockGetOrga();
    mockGetOrgas = MockGetOrgas();
    mockGetOrgaUsers = MockGetOrgaUsers();
    mockUpdateOrga = MockUpdateOrga();
    mockUpdateOrgaUser = MockUpdateOrgaUser();

    orgaBloc = OrgaBloc(
        mockAddOrga,
        mockAddOrgaUser,
        mockDeleteOrga,
        mockDeleteOrgaUser,
        mockEnableOrga,
        mockEnableOrgaUser,
        mockGetOrga,
        mockGetOrgas,
        mockGetOrgaUsers,
        mockUpdateOrga,
        mockUpdateOrgaUser);
  });

  final newOrgaId = Guid.newGuid.toString();
  final newUserId = Guid.newGuid.toString();

  final tOrga = Orga(
      id: newOrgaId,
      name: 'Test Orga',
      code: 'test',
      enabled: true,
      builtIn: false);

  final tOrgaUser = OrgaUser(
      userId: newUserId,
      orgaId: newOrgaId,
      roles: const <String>[Roles.Admin],
      enabled: true,
      builtIn: false);

  test(
    'el estado inicial debe ser Start',
    () {
      expect(orgaBloc.state, OrgaStart());
    },
  );

  group('conseguir organizaciones y orgausers', () {
    blocTest<OrgaBloc, OrgaState>(
      'debe lanzar el spinner y devolver estado con listado',
      build: () {
        when(mockGetOrgas.execute("", "", 1, 10))
            .thenAnswer((_) async => Right(<Orga>[tOrga]));
        return orgaBloc;
      },
      act: (bloc) => bloc.add(const OnOrgaListLoad("", "", 1)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        OrgaLoading(),
        OrgaListLoaded(<Orga>[tOrga]),
      ],
      verify: (bloc) {
        verify(mockGetOrgas.execute("", "", 1, 10));
      },
    );

    blocTest<OrgaBloc, OrgaState>(
      'debe lanzar el spinner y devolver estado con la orga',
      build: () {
        when(mockGetOrga.execute(newOrgaId))
            .thenAnswer((_) async => Right(tOrga));
        return orgaBloc;
      },
      act: (bloc) => bloc.add(OnOrgaLoad(newOrgaId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        OrgaLoading(),
        OrgaLoaded(tOrga),
      ],
      verify: (bloc) {
        verify(mockGetOrga.execute(newOrgaId));
      },
    );

    blocTest<OrgaBloc, OrgaState>(
      'debe lanzar el spinner y devolver estado con listado de orgausers',
      build: () {
        when(mockGetOrgaUsers.execute(newOrgaId))
            .thenAnswer((_) async => Right(<OrgaUser>[tOrgaUser]));
        return orgaBloc;
      },
      act: (bloc) => bloc.add(OnOrgaUserListLoad(newOrgaId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        OrgaLoading(),
        OrgaUserListLoaded(<OrgaUser>[tOrgaUser]),
      ],
      verify: (bloc) {
        verify(mockGetOrgaUsers.execute(newOrgaId));
      },
    );
  });

  group('agregar organizaciones y orgausers', () {
    blocTest<OrgaBloc, OrgaState>(
      'debe agregar un orga',
      build: () {
        when(mockAddOrga.execute(tOrga.name, tOrga.code, tOrga.enabled))
            .thenAnswer((_) async => Right(tOrga));
        return orgaBloc;
      },
      act: (bloc) => bloc.add(OnOrgaAdd(tOrga.name, tOrga.code, tOrga.enabled)),
      wait: const Duration(milliseconds: 500),
      expect: () => [OrgaLoading(), OrgaStart()],
      verify: (bloc) {
        verify(mockAddOrga.execute(tOrga.name, tOrga.code, tOrga.enabled));
      },
    );

    blocTest<OrgaBloc, OrgaState>(
      'debe agregar un orgauser',
      build: () {
        when(mockAddOrgaUser.execute(tOrgaUser.orgaId, tOrgaUser.userId,
                tOrgaUser.roles, tOrgaUser.enabled))
            .thenAnswer((_) async => Right(tOrgaUser));
        return orgaBloc;
      },
      act: (bloc) => bloc.add(OnOrgaUserAdd(tOrgaUser.orgaId, tOrgaUser.userId,
          tOrgaUser.roles, tOrgaUser.enabled)),
      wait: const Duration(milliseconds: 500),
      expect: () => [OrgaLoading(), OrgaStart()],
      verify: (bloc) {
        verify(mockAddOrgaUser.execute(tOrgaUser.orgaId, tOrgaUser.userId,
            tOrgaUser.roles, tOrgaUser.enabled));
      },
    );
  });

  group('eliminar orgas y orgausers', () {
    blocTest<OrgaBloc, OrgaState>(
      'debe eliminar un orga',
      build: () {
        when(mockDeleteOrga.execute(newOrgaId))
            .thenAnswer((_) async => const Right(true));
        return orgaBloc;
      },
      act: (bloc) => bloc.add(OnOrgaDelete(newOrgaId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [OrgaLoading(), OrgaStart()],
      verify: (bloc) {
        verify(mockDeleteOrga.execute(newOrgaId));
      },
    );

    blocTest<OrgaBloc, OrgaState>(
      'debe eliminar un orgauser',
      build: () {
        when(mockDeleteOrgaUser.execute(newOrgaId, newUserId))
            .thenAnswer((_) async => const Right(true));
        return orgaBloc;
      },
      act: (bloc) => bloc.add(OnOrgaUserDelete(newOrgaId, newUserId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [OrgaLoading(), OrgaStart()],
      verify: (bloc) {
        verify(mockDeleteOrgaUser.execute(newOrgaId, newUserId));
      },
    );
  });
  group('deshabilitar orgas y orgausers', () {
    blocTest<OrgaBloc, OrgaState>(
      'debe deshabilitar un orga',
      build: () {
        when(mockEnableOrga.execute(newOrgaId, false))
            .thenAnswer((_) async => Right(tOrga));
        return orgaBloc;
      },
      act: (bloc) => bloc.add(OnOrgaEnable(newOrgaId, false)),
      wait: const Duration(milliseconds: 500),
      expect: () => [OrgaLoading(), OrgaLoaded(tOrga)],
      verify: (bloc) {
        verify(mockEnableOrga.execute(newOrgaId, false));
      },
    );

    blocTest<OrgaBloc, OrgaState>(
      'debe deshabilitar un orgauser',
      build: () {
        when(mockEnableOrgaUser.execute(newOrgaId, newUserId, false))
            .thenAnswer((_) async => Right(tOrgaUser));
        return orgaBloc;
      },
      act: (bloc) => bloc.add(OnOrgaUserEnable(newOrgaId, newUserId, false)),
      wait: const Duration(milliseconds: 500),
      expect: () => [OrgaLoading(), OrgaStart()],
      verify: (bloc) {
        verify(mockEnableOrgaUser.execute(newOrgaId, newUserId, false));
      },
    );
  });
  group('actualizar orgas y orgausers', () {
    blocTest<OrgaBloc, OrgaState>(
      'debe actualizar un orga',
      build: () {
        when(mockUpdateOrga.execute(newOrgaId, tOrga))
            .thenAnswer((_) async => Right(tOrga));
        return orgaBloc;
      },
      act: (bloc) => bloc
          .add(OnOrgaEdit(newOrgaId, tOrga.name, tOrga.code, tOrga.enabled)),
      wait: const Duration(milliseconds: 500),
      expect: () => [OrgaLoading(), OrgaStart()],
      verify: (bloc) {
        verify(mockUpdateOrga.execute(newOrgaId, tOrga));
      },
    );

    blocTest<OrgaBloc, OrgaState>(
      'debe actualizar un orgauser',
      build: () {
        when(mockUpdateOrgaUser.execute(
                tOrgaUser.orgaId, tOrgaUser.userId, tOrgaUser))
            .thenAnswer((_) async => Right(tOrgaUser));
        return orgaBloc;
      },
      act: (bloc) => bloc.add(OnOrgaUserEdit(tOrgaUser.orgaId, tOrgaUser.userId,
          tOrgaUser.roles, tOrgaUser.enabled)),
      wait: const Duration(milliseconds: 500),
      expect: () => [OrgaLoading(), OrgaStart()],
      verify: (bloc) {
        verify(mockUpdateOrgaUser.execute(
            tOrgaUser.orgaId, tOrgaUser.userId, tOrgaUser));
      },
    );
  });
}
