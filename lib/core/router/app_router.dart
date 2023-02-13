import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/addcontent/pages/addcontent_page.dart';
import '../../presentation/home/pages/home_page.dart';
import '../../presentation/login/pages/login_page.dart';
import '../../presentation/nav/bloc/nav_bloc.dart';
import '../../presentation/nav/bloc/nav_event.dart';
import '../../presentation/nav/bloc/nav_state.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    //final GlobalKey<ScaffoldState> key = settings.arguments as GlobalKey<ScaffoldState>;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
      case '/addContent':
        return MaterialPageRoute(
          builder: (_) => AddContentPage(),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
    }
  }

  void _handleRouter(BuildContext context, NavItem item) {
    BlocProvider.of<NavBloc>(context).add(NavigateTo(item));
  }
}

