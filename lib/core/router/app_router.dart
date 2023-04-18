import 'package:flutter/material.dart';

import '../../presentation/nav/bloc/nav_state.dart';
import '../../presentation/router/pages/router_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name?.toLowerCase().contains('/p/') ?? false) {
      return MaterialPageRoute(
        builder: (context) => RouterPage(
            naveItem: NavItem.pagePost,
            args: <String, dynamic>{
              'id': settings.name?.replaceFirst('/p/', '')
            }),
      );
    }
    switch (settings.name?.toLowerCase()) {
      case '/recent':
        return MaterialPageRoute(
          builder: (context) => const RouterPage(naveItem: NavItem.pageRecent),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (context) => const RouterPage(naveItem: NavItem.pageLogin),
        );
      case '/addcontent':
        return MaterialPageRoute(
          builder: (context) =>
              const RouterPage(naveItem: NavItem.pageAddContent),
        );
      case '/profile':
        return MaterialPageRoute(
          builder: (context) => const RouterPage(naveItem: NavItem.pageProfile),
        );
      case '/orga':
        return MaterialPageRoute(
          builder: (context) => const RouterPage(naveItem: NavItem.pageOrgas),
        );
      case '/user':
        return MaterialPageRoute(
          builder: (context) => const RouterPage(naveItem: NavItem.pageUsers),
        );
      case '/role':
        return MaterialPageRoute(
          builder: (context) => const RouterPage(naveItem: NavItem.pageRoles),
        );
      case '/uploaded':
        return MaterialPageRoute(
          builder: (context) =>
              const RouterPage(naveItem: NavItem.pageUploaded),
        );
      case '/viewed':
        return MaterialPageRoute(
          builder: (context) => const RouterPage(naveItem: NavItem.pageVoted),
        );
      case '/popular':
        return MaterialPageRoute(
          builder: (context) => const RouterPage(naveItem: NavItem.pagePopular),
        );
      case '/tobeapproved':
        return MaterialPageRoute(
          builder: (context) =>
              const RouterPage(naveItem: NavItem.pageToBeApproved),
        );
      case '/approved':
        return MaterialPageRoute(
          builder: (context) =>
              const RouterPage(naveItem: NavItem.pageApproved),
        );
      case '/rejected':
        return MaterialPageRoute(
          builder: (context) =>
              const RouterPage(naveItem: NavItem.pageRejected),
        );
      case '/demolist':
        return MaterialPageRoute(
          builder: (context) =>
              const RouterPage(naveItem: NavItem.pageDemoList),
        );
      default:
        return null;
    }
  }
}
