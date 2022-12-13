import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/core/domain/usecases/get_has_login.dart';
import 'package:lomba_frontend/core/failures.dart';
import 'package:lomba_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:lomba_frontend/features/home/presentation/bloc/home_event.dart';
import 'package:lomba_frontend/features/home/presentation/bloc/home_state.dart';
import 'package:lomba_frontend/features/login/data/models/login_access_model.dart';
import 'package:lomba_frontend/features/login/domain/usecases/get_authenticate.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/login_bloc.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/login_event.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/login_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_bloc_test.mocks.dart';

@GenerateMocks([GetHasLogIn])
void main() {
  late MockGetHasLogIn mockGetHasLogIn;
  late HomeBloc homeBloc;

  setUp(() {
    mockGetHasLogIn = MockGetHasLogIn();
    homeBloc = HomeBloc(mockGetHasLogIn);
  });

  test(
    'debe tener un mensaje inicial en el home',
    () {
      expect(homeBloc.state, HomeStart());
    },
  );

  blocTest<HomeBloc, HomeState>(
    'debe responder con estado de login TRUE después de cargar',
    build: () {
      when(mockGetHasLogIn.execute())
          .thenAnswer((_) async => const Right(true));
      return homeBloc;
    },
    act: (bloc) => bloc.add(const OnHomeLoading()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      HomeLoading(),
      const HomeLoaded(true),
    ],
    verify: (bloc) {
      verify(mockGetHasLogIn.execute());
    },
  );

  blocTest<HomeBloc, HomeState>(
    'debe responder con estado de login FALSE después de cargar',
    build: () {
      when(mockGetHasLogIn.execute())
          .thenAnswer((_) async => const Right(false));
      return homeBloc;
    },
    act: (bloc) => bloc.add(const OnHomeLoading()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      HomeLoading(),
      const HomeLoaded(false),
    ],
    verify: (bloc) {
      verify(mockGetHasLogIn.execute());
    },
  );
}
