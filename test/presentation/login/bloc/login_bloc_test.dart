import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/data/models/session_model.dart';
import 'package:lomba_frontend/core/failures.dart';
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

  const tusername = "mp@mp.com";
  const tpassword = "12345678";

  test(
    'el estado inicial debe ser vacío',
    () {
      expect(loginBloc.state, LoginEmpty());
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
      const LoginGoted(tLoginAccess),
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
    expect: () => [
      LoginGetting(),
      const LoginError('Server failure'),
      const LoginGoted(tLoginAccess)
    ],
    verify: (bloc) {
      verify(mockGetAuthenticate.execute(tusername, tpassword));
    },
  );
}
