import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/presentation/nav/bloc/nav_bloc.dart';
import 'package:lomba_frontend/presentation/nav/bloc/nav_event.dart';
import 'package:lomba_frontend/presentation/nav/bloc/nav_state.dart';


Future<void> main() async {
  late NavBloc navBloc;

  setUp(() {
    navBloc = NavBloc();
  });

  const NavItem destination = NavItem.pageProfile;

  test(
    'el estado inicial debe ser Start',
    () {
      //assert
      expect(navBloc.state, const NavState(NavItem.pageHome));
    }
  );

  blocTest<NavBloc, NavState>(
    'debe emitir NavState',
    build: () {
      return navBloc;
    },
    act: (bloc) => bloc.add(const NavigateTo(destination)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      const NavState(destination)
    ],
  );
}