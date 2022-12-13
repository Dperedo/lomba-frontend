import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/core/failures.dart';
import 'package:lomba_frontend/features/login/data/models/login_access_model.dart';
import 'package:lomba_frontend/features/login/domain/usecases/get_authenticate.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/login_bloc.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/login_event.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/login_state.dart';
import 'package:lomba_frontend/features/sidedrawer/domain/usecases/do_logoff.dart';
import 'package:lomba_frontend/features/sidedrawer/domain/usecases/get_side_options.dart';
import 'package:lomba_frontend/features/sidedrawer/presentation/bloc/sidedrawer_bloc.dart';
import 'package:lomba_frontend/features/sidedrawer/presentation/bloc/sidedrawer_event.dart';
import 'package:lomba_frontend/features/sidedrawer/presentation/bloc/sidedrawer_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sidedrawer_bloc_test.mocks.dart';

@GenerateMocks([GetSideOptions, DoLogOff])
void main() {
  late MockGetSideOptions mockGetSideOptions;
  late MockDoLogOff mockDoLogOff;

  late SideDrawerBloc sideDrawerBloc;

  setUp(() {
    mockGetSideOptions = MockGetSideOptions();
    mockDoLogOff = MockDoLogOff();

    sideDrawerBloc = SideDrawerBloc(mockGetSideOptions, mockDoLogOff);
  });

  const listAnonymous = <String>["home", "login"];

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
      return sideDrawerBloc;
    },
    act: (bloc) => bloc.add(const OnSideDrawerLoading()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SideDrawerLoading(),
      const SideDrawerReady(listAnonymous),
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
