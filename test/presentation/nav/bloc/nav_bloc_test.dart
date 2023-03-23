import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/presentation/nav/bloc/nav_bloc.dart';
import 'package:lomba_frontend/presentation/nav/bloc/nav_state.dart';
import 'package:mockito/mockito.dart';

class MockBuildContext extends Mock implements BuildContext {}

Future<void> main() async {
  late NavBloc navBloc;
  late MockBuildContext mockContext;
  setUp(() {
    navBloc = NavBloc();

    mockContext = MockBuildContext();
  });

  const NavItem destination = NavItem.pageProfile;

  test('el estado inicial debe ser Start', () {
    //assert
    expect(navBloc.state, const NavState(NavItem.pageRecent));
  });
/*
  blocTest<NavBloc, NavState>(
    'debe emitir NavState',
    build: () {
      when(navBloc.state).thenReturn(const NavState(NavItem.pageRecent));
      return navBloc;
    },
    act: (bloc) {
      bloc.add(NavigateTo(destination, mockContext));
    },
    wait: const Duration(milliseconds: 500),
    expect: () => [const NavState(destination)],
  );
  */
}
