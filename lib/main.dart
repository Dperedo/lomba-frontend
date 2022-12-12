import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/presentation/bloc/nav_bloc.dart';
import 'package:lomba_frontend/features/login/presentation/pages/login_page.dart';
import 'package:lomba_frontend/features/orgas/presentation/pages/orgas_page.dart';

import 'core/presentation/bloc/nav_state.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/login/presentation/bloc/login_bloc.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/sidedrawer/presentation/bloc/sidedrawer_bloc.dart';
import 'injection.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  late Widget _content;

  @override
  void initState() {
    super.initState();
    var _bloc = NavBloc();
    _content = _bodyForState(_bloc.state);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<LoginBloc>()),
        BlocProvider(create: (_) => di.locator<HomeBloc>()),
        BlocProvider(create: (_) => di.locator<SideDrawerBloc>()),
        BlocProvider(create: (_) => di.locator<NavBloc>())
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: BlocBuilder<NavBloc, NavState>(builder: (context, state) {
            return AnimatedSwitcher(
              switchInCurve: Curves.easeInExpo,
              switchOutCurve: Curves.easeOutExpo,
              duration: const Duration(milliseconds: 300),
              child: _bodyForState(state),
            );
          })),
    );
  }

  _bodyForState(NavState state) {
    if (state.selectedItem == NavItem.page_home) {
      return const HomePage();
    }
    if (state.selectedItem == NavItem.page_login) {
      return LoginPage();
    }
    if (state.selectedItem == NavItem.page_orgas) {
      return const OrgasPage();
    }
  }
}
