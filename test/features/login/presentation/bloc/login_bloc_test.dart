import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/failures.dart';
import 'package:lomba_frontend/features/login/domain/entities/token.dart';
import 'package:lomba_frontend/features/login/domain/usecases/get_authenticate.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/login_bloc.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/login_event.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/login_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks([GetAuthenticate])
void main() {
  late MockGetAuthenticate mockGetAuthenticate;
  late LoginBloc loginBloc;

  setUp(() {
    mockGetAuthenticate = MockGetAuthenticate();
    loginBloc = LoginBloc(mockGetAuthenticate);
  });

  const tToken = Token(id: 'mp@mp.com', username: 'mp@mp.com');
  const tusername = "mp@mp.com";
  const tpassword = "12345678";

  test(
    'el estado inicial debe ser vacío',
    () {
      expect(loginBloc.state, LoginEmpty());
    },
  );

  blocTest<LoginBloc, LoginState>(
    'debe emitir -getting- y -gottoken- cuando se consigue el token correctamente',
    build: () {
      when(mockGetAuthenticate.execute(tusername, tpassword))
          .thenAnswer((_) async => Right(tToken));
      return loginBloc;
    },
    act: (bloc) => bloc.add(OnLoginTriest(tusername, tpassword)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      LoginGetting(),
      LoginGot(tToken),
    ],
    verify: (bloc) {
      verify(mockGetAuthenticate.execute(tusername, tpassword));
    },
  );

  blocTest<LoginBloc, LoginState>(
    'debe emitir getting y error cuando no consigue el token',
    build: () {
      when(mockGetAuthenticate.execute(tusername, tpassword))
          .thenAnswer((_) async => Left(ServerFailure('Server failure')));
      return loginBloc;
    },
    act: (bloc) => bloc.add(OnLoginTriest(tusername, tpassword)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      LoginGetting(),
      LoginError('Server failure'),
    ],
    verify: (bloc) {
      verify(mockGetAuthenticate.execute(tusername, tpassword));
    },
  );
}
