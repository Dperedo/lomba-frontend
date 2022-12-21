import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/presentation/bloc/nav_bloc.dart';
import 'package:lomba_frontend/features/approved/presentation/pages/approved_page.dart';
import 'package:lomba_frontend/features/login/presentation/pages/login_page.dart';
import 'package:lomba_frontend/features/orgas/presentation/pages/orgas_page.dart';
import 'package:lomba_frontend/features/popular/presentation/pages/popular_page.dart';
import 'package:lomba_frontend/features/tobeapproved/presentation/pages/tobeapproved_page.dart';
import 'package:lomba_frontend/features/uploaded/presentation/pages/uploaded_page.dart';
import 'package:lomba_frontend/features/viewed/presentation/pages/viewed_page.dart';

import 'core/presentation/bloc/nav_state.dart';
import 'features/addcontent/presentation/pages/addcontent_page.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/login/presentation/bloc/login_bloc.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/orgas/presentation/bloc/orga_bloc.dart';
import 'features/orgas/presentation/bloc/orgauser_bloc.dart';
import 'features/profile/presentation/pages/profile_page.dart';
import 'features/rejected/presentation/pages/rejected_page.dart';
import 'features/roles/presentation/bloc/role_bloc.dart';
import 'features/roles/presentation/pages/role_page.dart';
import 'features/sidedrawer/presentation/bloc/sidedrawer_bloc.dart';
import 'features/users/presentation/bloc/user_bloc.dart';
import 'features/users/presentation/pages/users_page.dart';
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
        BlocProvider(create: (_) => di.locator<OrgaUserBloc>()),
        BlocProvider(create: (_) => di.locator<UserBloc>()),
        BlocProvider(create: (_) => di.locator<RoleBloc>())
      ],
      child: MaterialApp(
          title: 'App Demo',
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
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
    if (state.selectedItem == NavItem.pageUsers) {
      return const UsersPage();
    }
    if (state.selectedItem == NavItem.pageRoles) {
      return const RolesPage();
    }

    if (state.selectedItem == NavItem.pageAddContent) {
      return const AddContentPage();
    }

    if (state.selectedItem == NavItem.pageApproved) {
      return const ApprovedPage();
    }

    if (state.selectedItem == NavItem.pagePopular) {
      return const PopularPage();
    }

    if (state.selectedItem == NavItem.pageRejected) {
      return const RejectedPage();
    }

    if (state.selectedItem == NavItem.pageToBeApproved) {
      return const ToBeApprovedPage();
    }
    if (state.selectedItem == NavItem.pageUploaded) {
      return const UploadedPage();
    }

    if (state.selectedItem == NavItem.pageViewed) {
      return const ViewedPage();
    }
    if (state.selectedItem == NavItem.pageProfile) {
      return const ProfilePage();
    }
  }
}
