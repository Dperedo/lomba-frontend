import 'package:flutter/material.dart';

import '../../presentation/addcontent/pages/addcontent_page.dart';
import '../../presentation/home/pages/home_page.dart';
import '../../presentation/login/pages/login_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    final Object? key = settings.arguments;
    switch (settings.name) {
      case '/Home':
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
        return null;
    }
  }
}