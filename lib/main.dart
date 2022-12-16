import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/presentation/bloc/nav_bloc.dart';
import 'package:lomba_frontend/features/login/presentation/pages/login_page.dart';
import 'package:lomba_frontend/features/orgas/presentation/pages/orgas_page.dart';

import 'core/presentation/bloc/nav_state.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/login/presentation/bloc/login_bloc.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/orgas/presentation/bloc/orga_bloc.dart';
import 'features/orgas/presentation/bloc/orgauser_bloc.dart';
import 'features/sidedrawer/presentation/bloc/sidedrawer_bloc.dart';
import 'injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<NavBloc>()),
        BlocProvider(create: (_) => di.locator<SideDrawerBloc>()),
        BlocProvider(create: (_) => di.locator<HomeBloc>()),
        BlocProvider(create: (_) => di.locator<LoginBloc>()),
        BlocProvider(create: (_) => di.locator<OrgaBloc>()),
        BlocProvider(create: (_) => di.locator<OrgaUserBloc>())
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
    if (state.selectedItem == NavItem.pageHome) {
      return const HomePage();
    }
    if (state.selectedItem == NavItem.pageLogin) {
      return LoginPage();
    }
    if (state.selectedItem == NavItem.pageOrgas) {
      return const OrgasPage();
    }
  }
}
