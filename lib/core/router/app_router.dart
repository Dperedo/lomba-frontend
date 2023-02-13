import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/addcontent/pages/addcontent_page.dart';
import '../../presentation/home/pages/home_page.dart';
import '../../presentation/nav/bloc/nav_state.dart';
import '../widgets/router_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name?.toLowerCase()) {
      case '/home':
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
      case '/addcontent':
        return MaterialPageRoute(
          builder: (_) => AddContentPage(),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (context) => const RouterPage(naveItem: NavItem.pageLogin),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
    }
  }
}
