import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/data/models/session_model.dart';
import 'package:lomba_frontend/domain/usecases/local/get_has_login.dart';
import 'package:lomba_frontend/domain/usecases/local/get_session_status.dart';
import 'package:lomba_frontend/domain/usecases/login/change_orga.dart';
import 'package:lomba_frontend/data/models/orga_model.dart';
import 'package:lomba_frontend/domain/entities/orga.dart';
import 'package:lomba_frontend/domain/usecases/orgas/get_orga.dart';
import 'package:lomba_frontend/domain/usecases/orgas/get_orgasbyuser.dart';
import 'package:lomba_frontend/domain/usecases/sidedrawer/do_logoff.dart';
import 'package:lomba_frontend/domain/usecases/sidedrawer/get_side_options.dart';
import 'package:lomba_frontend/presentation/sidedrawer/bloc/sidedrawer_bloc.dart';
import 'package:lomba_frontend/presentation/sidedrawer/bloc/sidedrawer_event.dart';
import 'package:lomba_frontend/presentation/sidedrawer/bloc/sidedrawer_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sidedrawer_bloc_test.mocks.dart';

@GenerateMocks([
  GetSideOptions,
  DoLogOff,
  GetSession,
  GetOrgasByUser,
  GetHasLogIn,
  GetOrga,
  ChangeOrga
])
void main() {
  late MockGetSideOptions mockGetSideOptions;
  late MockDoLogOff mockDoLogOff;
  late MockGetSession mockGetSession;
  late MockGetOrgasByUser mockGetOrgasByUser;
  late MockGetHasLogIn mockGetHasLogIn;
  late MockGetOrga mockGetOrga;
  late MockChangeOrga mockChangeOrga;

  late SideDrawerBloc sideDrawerBloc;

  setUp(() {
    mockGetSideOptions = MockGetSideOptions();
    mockDoLogOff = MockDoLogOff();
    mockGetSession = MockGetSession();
    mockGetHasLogIn = MockGetHasLogIn();
    mockGetOrga = MockGetOrga();
    mockGetOrgasByUser = MockGetOrgasByUser();
    mockChangeOrga = MockChangeOrga();

    sideDrawerBloc = SideDrawerBloc(
        mockGetSideOptions,
        mockDoLogOff,
        mockGetSession,
        mockGetOrgasByUser,
        mockGetHasLogIn,
        mockGetOrga,
        mockChangeOrga);
  });

  const userId = '00000002-0002-0002-0002-000000000002';
  const listAnonymous = <String>["home", "login"];
  const tSession = SessionModel(
      token: SystemKeys.tokenSuperAdmin2023,
      username: 'rev@mp.com',
      name: 'Revisor');
  const tOrga = Orga(
      id: '00000002-0002-0002-0002-000000000002',
      name: 'Test Orga',
      code: 'test',
      enabled: true,
      builtIn: false);

  test(
    'el estado inicial de sidedraer debe ser vacío',
    () {
      expect(sideDrawerBloc.state, SideDrawerEmpty());
    },
  );

  blocTest<SideDrawerBloc, SideDrawerState>(
    'debe emitir loading antes de ready',
    build: () {
      when(mockGetSideOptions.execute())
          .thenAnswer((_) async => const Right(listAnonymous));
      when(mockGetHasLogIn.execute())
          .thenAnswer((_) async => const Right(true));
      when(mockGetSession.execute())
          .thenAnswer((_) async => const Right(tSession));
      when(mockGetOrgasByUser.execute('00000001-0001-0001-0001-000000000001'))
          .thenAnswer((_) async => const Right(<Orga>[tOrga]));
      return sideDrawerBloc;
    },
    act: (bloc) => bloc.add(const OnSideDrawerLoading()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SideDrawerLoading(),
      const SideDrawerReady(
          listAnonymous, <Orga>[tOrga], '00000100-0100-0100-0100-000000000100'),
    ],
    verify: (bloc) {
      verify(mockGetSideOptions.execute());
    },
  );

  blocTest<SideDrawerBloc, SideDrawerState>(
    'debe cerrar sesión ',
    build: () {
      when(mockDoLogOff.execute()).thenAnswer((_) async => const Right(true));
      return sideDrawerBloc;
    },
    act: (bloc) => bloc.add(OnSideDrawerLogOff()),
    wait: const Duration(milliseconds: 500),
    expect: () => [SideDrawerEmpty()],
    verify: (bloc) {
      verify(mockDoLogOff.execute());
    },
  );
}
