import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/presentation/addcontent/bloc/addcontent_bloc.dart';
import 'package:lomba_frontend/presentation/approved/bloc/approved_bloc.dart';
import 'package:lomba_frontend/presentation/detailed_list/bloc/detailed_list_bloc.dart';
import 'package:lomba_frontend/presentation/detailed_list/page/detailed_list_page.dart';
import 'package:lomba_frontend/presentation/flow/bloc/flow_bloc.dart';
import 'package:lomba_frontend/presentation/flow/page/flow_page.dart';
import 'package:lomba_frontend/presentation/nav/bloc/nav_bloc.dart';
import 'package:lomba_frontend/presentation/approved/pages/approved_page.dart';
import 'package:lomba_frontend/presentation/login/pages/login_page.dart';
import 'package:lomba_frontend/presentation/orgas/pages/orgas_page.dart';
import 'package:lomba_frontend/presentation/popular/bloc/popular_bloc.dart';
import 'package:lomba_frontend/presentation/popular/pages/popular_page.dart';
import 'package:lomba_frontend/presentation/post/bloc/post_bloc.dart';
import 'package:lomba_frontend/presentation/post/pages/post_page.dart';
import 'package:lomba_frontend/presentation/router/bloc/router_bloc.dart';
import 'package:lomba_frontend/presentation/setting_admin/bloc/setting_admin_bloc.dart';
import 'package:lomba_frontend/presentation/setting_admin/page/setting_admin_page.dart';
import 'package:lomba_frontend/presentation/setting_super/bloc/setting_super_bloc.dart';
import 'package:lomba_frontend/presentation/setting_super/page/setting_super_page.dart';
import 'package:lomba_frontend/presentation/stage/page/stage_page.dart';
import 'package:lomba_frontend/presentation/tobeapproved/bloc/tobeapproved_bloc.dart';
import 'package:lomba_frontend/presentation/tobeapproved/pages/tobeapproved_page.dart';
import 'package:lomba_frontend/presentation/rejected/bloc/rejected_bloc.dart';
import 'package:lomba_frontend/presentation/uploaded/bloc/uploaded_bloc.dart';
import 'package:lomba_frontend/presentation/uploaded/pages/uploaded_page.dart';
import 'package:lomba_frontend/presentation/voted/pages/voted_page.dart';
import 'package:lomba_frontend/presentation/voted/bloc/voted_bloc.dart';

import 'core/router/app_router.dart';
import 'presentation/nav/bloc/nav_state.dart';
import 'presentation/addcontent/pages/addcontent_page.dart';
import 'presentation/demolist/bloc/demolist_bloc.dart';
import 'presentation/demolist/pages/demolist_page.dart';
import 'presentation/recent/bloc/recent_bloc.dart';
import 'presentation/recent/pages/recent_page.dart';
import 'presentation/login/bloc/login_bloc.dart';
import 'presentation/orgas/bloc/orga_bloc.dart';
import 'presentation/orgas/bloc/orgauser_bloc.dart';
import 'presentation/profile/bloc/profile_bloc.dart';
import 'presentation/profile/pages/profile_page.dart';
import 'presentation/rejected/pages/rejected_page.dart';
import 'presentation/roles/bloc/role_bloc.dart';
import 'presentation/roles/pages/role_page.dart';
import 'presentation/sidedrawer/bloc/sidedrawer_bloc.dart';
import 'presentation/stage/bloc/stage_bloc.dart';
import 'presentation/users/bloc/user_bloc.dart';
import 'presentation/users/pages/users_page.dart';
import 'injection.dart' as di;
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //usePathUrlStrategy();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  final AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<NavBloc>()),
        BlocProvider(create: (_) => di.locator<SideDrawerBloc>()),
        BlocProvider(create: (_) => di.locator<RecentBloc>()),
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
        BlocProvider(create: (_) => di.locator<VotedBloc>()),
        BlocProvider(create: (_) => di.locator<AddContentBloc>()),
        BlocProvider(create: (_) => di.locator<ToBeApprovedBloc>()),
        BlocProvider(create: (_) => di.locator<PopularBloc>()),
        BlocProvider(create: (_) => di.locator<RouterPageBloc>()),
        BlocProvider(create: (_) => di.locator<FlowBloc>()),
        BlocProvider(create: (_) => di.locator<StageBloc>()),
        BlocProvider(create: (_) => di.locator<DetailedListBloc>()),
        BlocProvider(create: (_) => di.locator<SettingSuperBloc>()),
        BlocProvider(create: (_) => di.locator<SettingAdminBloc>()),
        BlocProvider(create: (_) => di.locator<PostBloc>()),
      ],
      child: MaterialApp(
        title: 'App Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: BlocBuilder<NavBloc, NavState>(builder: (context, state) {
          return _animatedSwitcher(state);
        }),
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }

  AnimatedSwitcher _animatedSwitcher(NavState state) {
    return AnimatedSwitcher(
      switchInCurve: Curves.easeInExpo,
      switchOutCurve: Curves.easeOutExpo,
      duration: const Duration(milliseconds: 200),
      child: _bodyForState(state),
    );
  }

  dynamic _bodyForState(NavState state) {
    if (state.selectedItem == NavItem.pageRecent) {
      return RecentPage();
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
      return AddContentPage();
    }

    if (state.selectedItem == NavItem.pageApproved) {
      return ApprovedPage();
    }

    if (state.selectedItem == NavItem.pagePopular) {
      return PopularPage();
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

    if (state.selectedItem == NavItem.pageVoted) {
      return VotedPage();
    }
    if (state.selectedItem == NavItem.pageProfile) {
      return const ProfilePage();
    }
    if (state.selectedItem == NavItem.pageDemoList) {
      return DemoListPage();
    }
    if (state.selectedItem == NavItem.pageDetailedList) {
      return DetailedListPage();
    }
    if (state.selectedItem == NavItem.pageFlow) {
      return const FlowPage();
    }
    if (state.selectedItem == NavItem.pageStage) {
      return const StagePage();
    }
    if (state.selectedItem == NavItem.pageSettingSuper) {
      return const SettingSuperPage();
    }
    if (state.selectedItem == NavItem.pageSettingAdmin) {
      return const SettingAdminPage();
    }
    if (state.selectedItem == NavItem.pagePost) {
      return PostPage(postId: state.args!["id"].toString());
    }
  }
}
