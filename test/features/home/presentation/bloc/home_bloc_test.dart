import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/domain/usecases/get_has_login.dart';
import 'package:lomba_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:lomba_frontend/features/home/presentation/bloc/home_event.dart';
import 'package:lomba_frontend/features/home/presentation/bloc/home_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_bloc_test.mocks.dart';

@GenerateMocks([GetHasLogIn, FirebaseAuth])
void main() {
  late MockGetHasLogIn mockGetHasLogIn;
  late HomeBloc homeBloc;
  late MockFirebaseAuth mockFirebaseAuthInstance;

  setUp(() {
    mockGetHasLogIn = MockGetHasLogIn();
    mockFirebaseAuthInstance = MockFirebaseAuth();
    homeBloc = HomeBloc(mockFirebaseAuthInstance, mockGetHasLogIn);
  });

  test(
    'debe tener un mensaje inicial en el home',
    () {
      expect(homeBloc.state, HomeStart());
    },
  );

  blocTest<HomeBloc, HomeState>(
    'debe responder con estado con home cargado',
    build: () {
      when(mockGetHasLogIn.execute())
          .thenAnswer((_) async => const Right(true));
      when(mockFirebaseAuthInstance.signInAnonymously())
          .thenAnswer((realInvocation) async => any as UserCredential);
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
      when(mockFirebaseAuthInstance.signInAnonymously())
          .thenAnswer((realInvocation) async => any as UserCredential);
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
      //verifyNever(mockFirebaseAuthInstance.signInAnonymously());
    },
  );
}
