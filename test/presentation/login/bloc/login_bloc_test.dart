import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/data/models/session_model.dart';
import 'package:lomba_frontend/core/failures.dart';
import 'package:lomba_frontend/domain/entities/orga.dart';
import 'package:lomba_frontend/domain/usecases/login/change_orga.dart';
import 'package:lomba_frontend/domain/usecases/login/get_authenticate.dart';
import 'package:lomba_frontend/domain/usecases/login/get_authenticate_google.dart';
import 'package:lomba_frontend/presentation/login/bloc/login_bloc.dart';
import 'package:lomba_frontend/presentation/login/bloc/login_event.dart';
import 'package:lomba_frontend/presentation/login/bloc/login_state.dart';
import 'package:lomba_frontend/domain/usecases/orgas/get_orgasbyuser.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks(
    [GetAuthenticate, GetOrgasByUser, ChangeOrga, GetAuthenticateGoogle])
void main() {
  late MockGetAuthenticate mockGetAuthenticate;
  late MockGetOrgasByUser mockGetOrgasByUser;
  late MockChangeOrga mockChangeOrga;
  late MockGetAuthenticateGoogle mockGetAuthenticateGoogle;
  late LoginBloc loginBloc;

  setUp(() {
    mockGetAuthenticate = MockGetAuthenticate();
    mockGetOrgasByUser = MockGetOrgasByUser();
    mockChangeOrga = MockChangeOrga();
    mockGetAuthenticateGoogle = MockGetAuthenticateGoogle();
    loginBloc = LoginBloc(mockGetAuthenticate, mockGetOrgasByUser,
        mockChangeOrga, mockGetAuthenticateGoogle);
  });

  const tLoginAccess = SessionModel(
      token: SystemKeys.tokenSuperAdmin2023,
      username: 'admin@mp.com',
      name: 'admin@mp.com');

  const tLoginAccessMultiOrga = SessionModel(
      token: SystemKeys.tokenDoubleOrga,
      username: 'admin@mp.com',
      name: 'admin@mp.com');

  const tusername = "mp@mp.com";
  const tpassword = "12345678";
  const String test_userId = "00000007-0007-0007-0007-000000000007";
  const String test_orgaId = "00000200-0200-0200-0200-000000000200";
  const List<Orga> test_listOrga = [];

  test(
    'el estado inicial debe ser vacío',
    () {
      expect(loginBloc.state, LoginStart());
    },
  );

  blocTest<LoginBloc, LoginState>(
    'debe emitir -getting- y -goted- cuando se consigue el token correctamente',
    build: () {
      when(mockGetAuthenticate.execute(tusername, tpassword))
          .thenAnswer((_) async => const Right(tLoginAccess));
      return loginBloc;
    },
    act: (bloc) => bloc.add(const OnLoginTriest(tusername, tpassword)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      LoginGetting(),
      const LoginGoted(tLoginAccess, " Bienvenido usuario $tusername"),
    ],
    verify: (bloc) {
      verify(mockGetAuthenticate.execute(tusername, tpassword));
    },
  );

  blocTest<LoginBloc, LoginState>(
    'debe emitir getting y error cuando no consigue el token',
    build: () {
      when(mockGetAuthenticate.execute(tusername, tpassword))
          .thenAnswer((_) async => const Left(ServerFailure('Server failure')));
      return loginBloc;
    },
    act: (bloc) => bloc.add(const OnLoginTriest(tusername, tpassword)),
    wait: const Duration(milliseconds: 500),
    expect: () => [LoginGetting(), const LoginError('Server failure')],
    verify: (bloc) {
      verify(mockGetAuthenticate.execute(tusername, tpassword));
    },
  );

  blocTest<LoginBloc, LoginState>(
    'debe emitir -SelectOrga- y -goted- cuando se consigue el token correctamente',
    build: () {
      when(mockGetAuthenticate.execute(tusername, tpassword))
          .thenAnswer((_) async => const Right(tLoginAccessMultiOrga));
      when(mockGetOrgasByUser.execute(any))
          .thenAnswer((_) async => const Right(test_listOrga));
      return loginBloc;
    },
    act: (bloc) => bloc.add(const OnLoginTriest(tusername, tpassword)),
    wait: const Duration(milliseconds: 500),
    expect: () =>
        [LoginGetting(), const LoginSelectOrga(test_listOrga, tusername)],
    verify: (bloc) {
      verify(mockGetAuthenticate.execute(tusername, tpassword));
      verify(mockGetOrgasByUser.execute(test_userId));
    },
  );

  blocTest<LoginBloc, LoginState>(
    'debe emitir el evento -LoginStart- para reiniciar la pantalla de login',
    build: () {
      return loginBloc;
    },
    act: (bloc) => bloc.add(OnLoginStarter()),
    wait: const Duration(milliseconds: 500),
    expect: () => [LoginStart()],
    verify: (bloc) {},
  );

  blocTest<LoginBloc, LoginState>(
    'debe emitir el evento -Goted- con la nueva sesión con orgaId',
    build: () {
      when(mockChangeOrga.execute(tLoginAccess.username, test_orgaId))
          .thenAnswer((_) async => const Right(tLoginAccess));
      return loginBloc;
    },
    act: (bloc) =>
        bloc.add(OnLoginChangeOrga(tLoginAccess.username, test_orgaId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [LoginGetting(), const LoginGoted(tLoginAccess, '')],
    verify: (bloc) {},
  );
}
