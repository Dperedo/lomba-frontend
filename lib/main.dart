import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/presentation/addcontent/bloc/addcontent_bloc.dart';
import 'package:lomba_frontend/presentation/approved/bloc/approved_bloc.dart';
import 'package:lomba_frontend/presentation/nav/bloc/nav_bloc.dart';
import 'package:lomba_frontend/presentation/approved/pages/approved_page.dart';
import 'package:lomba_frontend/presentation/login/pages/login_page.dart';
import 'package:lomba_frontend/presentation/orgas/pages/orgas_page.dart';
import 'package:lomba_frontend/presentation/popular/presentation/pages/popular_page.dart';
import 'package:lomba_frontend/presentation/rejected/bloc/rejected_bloc.dart';
import 'package:lomba_frontend/presentation/tobeapproved/pages/tobeapproved_page.dart';
import 'package:lomba_frontend/presentation/tobeapproved/bloc/tobeapproved_bloc.dart';
import 'package:lomba_frontend/presentation/uploaded/bloc/uploaded_bloc.dart';
import 'package:lomba_frontend/presentation/uploaded/presentation/pages/uploaded_page.dart';
import 'package:lomba_frontend/presentation/viewed/presentation/pages/viewed_page.dart';

import 'presentation/nav/bloc/nav_state.dart';
import 'presentation/addcontent/pages/addcontent_page.dart';
import 'presentation/demolist/bloc/demolist_bloc.dart';
import 'presentation/demolist/pages/demolist_page.dart';
import 'presentation/home/bloc/home_bloc.dart';
import 'presentation/home/pages/home_page.dart';
import 'presentation/login/bloc/login_bloc.dart';
import 'presentation/orgas/bloc/orga_bloc.dart';
import 'presentation/orgas/bloc/orgauser_bloc.dart';
import 'presentation/profile/bloc/profile_bloc.dart';
import 'presentation/profile/pages/profile_page.dart';
import 'presentation/rejected/presentation/pages/rejected_page.dart';
import 'presentation/roles/bloc/role_bloc.dart';
import 'presentation/roles/pages/role_page.dart';
import 'presentation/sidedrawer/bloc/sidedrawer_bloc.dart';
import 'presentation/users/bloc/user_bloc.dart';
import 'presentation/users/pages/users_page.dart';
import 'injection.dart' as di;
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await di.init();
  print("1.0.0.2");
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
        BlocProvider(create: (_) => di.locator<RoleBloc>()),
        BlocProvider(create: (_) => di.locator<ProfileBloc>()),
        BlocProvider(create: (_) => di.locator<DemoListBloc>()),
        BlocProvider(create: (_) => di.locator<UploadedBloc>()),
        BlocProvider(create: (_) => di.locator<ApprovedBloc>()),
        BlocProvider(create: (_) => di.locator<RejectedBloc>()),
        BlocProvider(create: (_) => di.locator<AddContentBloc>()),
        BlocProvider(create: (_) => di.locator<ApprovedBloc>()),
        BlocProvider(create: (_) => di.locator<ToBeApprovedBloc>()),
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
      return OrgasPage();
    }
    if (state.selectedItem == NavItem.pageUsers) {
      return UsersPage();
    }
    if (state.selectedItem == NavItem.pageRoles) {
      return const RolesPage();
    }

    if (state.selectedItem == NavItem.pageAddContent) {
      return const AddContentPage();
    }

    if (state.selectedItem == NavItem.pageApproved) {
      return ApprovedPage();
    }

    if (state.selectedItem == NavItem.pagePopular) {
      return const PopularPage();
    }

    if (state.selectedItem == NavItem.pageRejected) {
      return RejectedPage();
    }

    if (state.selectedItem == NavItem.pageToBeApproved) {
      return ToBeApprovedPage();
    }
    if (state.selectedItem == NavItem.pageUploaded) {
      return UploadedPage();
    }

    if (state.selectedItem == NavItem.pageViewed) {
      return const ViewedPage();
    }
    if (state.selectedItem == NavItem.pageProfile) {
      return const ProfilePage();
    }
    if (state.selectedItem == NavItem.pageDemoList) {
      return DemoListPage();
    }
  }
}
