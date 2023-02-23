import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/domain/entities/orga.dart';
import 'package:lomba_frontend/domain/usecases/orgas/add_orga.dart';
import 'package:lomba_frontend/domain/usecases/orgas/delete_orga.dart';
import 'package:lomba_frontend/domain/usecases/orgas/enable_orga.dart';
import 'package:lomba_frontend/domain/usecases/orgas/exists_orga.dart';
import 'package:lomba_frontend/domain/usecases/orgas/get_orga.dart';
import 'package:lomba_frontend/domain/usecases/orgas/get_orgas.dart';
import 'package:lomba_frontend/domain/usecases/orgas/update_orga.dart';
import 'package:lomba_frontend/presentation/orgas/bloc/orga_bloc.dart';
import 'package:lomba_frontend/presentation/orgas/bloc/orga_event.dart';
import 'package:lomba_frontend/presentation/orgas/bloc/orga_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../users/bloc/user_bloc_test.mocks.dart';
import 'orga_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AddOrga>(),
  MockSpec<DeleteOrga>(),
  MockSpec<EnableOrga>(),
  MockSpec<GetOrga>(),
  MockSpec<GetOrgas>(),
  MockSpec<UpdateOrga>(),
  MockSpec<ExistsOrga>(),
])
Future<void> main() async {
  late AddOrga mockAddOrga;
  late DeleteOrga mockDeleteOrga;
  late EnableOrga mockEnableOrga;
  late GetOrga mockGetOrga;
  late GetOrgas mockGetOrgas;
  late UpdateOrga mockUpdateOrga;
  late ExistsOrga mockExistsOrga;

  late OrgaBloc orgaBloc;

  setUp(() {
    mockAddOrga = MockAddOrga();
    mockDeleteOrga = MockDeleteOrga();
    mockEnableOrga = MockEnableOrga();
    mockGetOrga = MockGetOrga();
    mockGetOrgas = MockGetOrgas();
    mockUpdateOrga = MockUpdateOrga();
    mockExistsOrga = MockExistsOrga();

    orgaBloc = OrgaBloc(
      mockAddOrga,
      mockDeleteOrga,
      mockEnableOrga,
      mockGetOrga,
      mockGetOrgas,
      mockUpdateOrga,
      mockExistsOrga,
    );
  });

  final newOrgaId = Guid.newGuid.toString();
  final newCode = Guid.newGuid.toString();

  final tOrga = Orga(
      id: newOrgaId,
      name: 'Test Orga',
      code: 'test',
      enabled: true,
      builtIn: false);

  test(
    'el estado inicial debe ser Start',
    () {
      expect(orgaBloc.state, const OrgaStart(""));
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
        OrgaLoaded(tOrga, ""),
      ],
      verify: (bloc) {
        verify(mockGetOrga.execute(newOrgaId));
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
      expect: () => [
        OrgaLoading(),
        OrgaStart(" La organización ${tOrga.name} fue creada")
      ],
      verify: (bloc) {
        verify(mockAddOrga.execute(tOrga.name, tOrga.code, tOrga.enabled));
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
      act: (bloc) => bloc.add(OnOrgaDelete(newOrgaId, 'orga')),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        OrgaLoading(),
        const OrgaStart(" La organización orga fue eliminado")
      ],
      verify: (bloc) {
        verify(mockDeleteOrga.execute(newOrgaId));
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
      act: (bloc) => bloc.add(OnOrgaEnable(newOrgaId, false, 'orga')),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        OrgaLoading(),
        OrgaLoaded(tOrga, " La organización orga fue deshabilitado")
      ],
      verify: (bloc) {
        verify(mockEnableOrga.execute(newOrgaId, false));
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
      expect: () => [
        OrgaLoading(),
        OrgaStart(" La organización ${tOrga.name} fue actualizado")
      ],
      verify: (bloc) {
        verify(mockUpdateOrga.execute(newOrgaId, tOrga));
      },
    );
  });
  group('modificar orgas', () {
    blocTest<OrgaBloc, OrgaState>(
      'debe mostrar form para editar orga',
      build: () {
        return orgaBloc;
      },
      act: (bloc) => bloc.add(OnOrgaPrepareForEdit(tOrga)),
      wait: const Duration(milliseconds: 500),
      expect: () => [OrgaEditing(tOrga, true)],
      verify: (bloc) {},
    );
    blocTest<OrgaBloc, OrgaState>(
      'debe guardar cambios',
      build: () {
        when(mockUpdateOrga.execute(newOrgaId, tOrga))
            .thenAnswer((_) async => Right(tOrga));
        return orgaBloc;
      },
      act: (bloc) => bloc
          .add(OnOrgaEdit(newOrgaId, tOrga.name, tOrga.code, tOrga.enabled)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        OrgaLoading(),
        OrgaStart(" La organización ${tOrga.name} fue actualizado")
      ],
      verify: (bloc) {
        verify(mockUpdateOrga.execute(newOrgaId, tOrga));
      },
    );
  });
}
