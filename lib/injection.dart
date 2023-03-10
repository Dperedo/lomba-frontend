import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:lomba_frontend/domain/usecases/post/add_text_post.dart';
import 'package:lomba_frontend/domain/usecases/post/delete_post.dart';
import 'package:lomba_frontend/domain/usecases/post/get_approved_posts.dart';
import 'package:lomba_frontend/domain/usecases/post/get_for_approve_posts.dart';
import 'package:lomba_frontend/domain/usecases/post/get_latest_posts.dart';
import 'package:lomba_frontend/domain/usecases/post/get_popular_posts.dart';
import 'package:lomba_frontend/domain/usecases/post/get_rejected_posts.dart';
import 'package:lomba_frontend/domain/usecases/post/get_uploaded_posts.dart';
import 'package:lomba_frontend/domain/usecases/post/get_voted_posts.dart';
import 'package:lomba_frontend/domain/usecases/post/update_edit.dart';
import 'package:lomba_frontend/domain/usecases/post/vote_publication.dart';
import 'package:lomba_frontend/domain/usecases/login/change_orga.dart';
import 'package:lomba_frontend/domain/usecases/login/get_authenticate.dart';
import 'package:lomba_frontend/domain/usecases/login/get_authenticate_google.dart';
import 'package:lomba_frontend/domain/usecases/login/register_user.dart';
import 'package:lomba_frontend/presentation/addcontent/bloc/addcontent_bloc.dart';
import 'package:lomba_frontend/presentation/approved/bloc/approved_bloc.dart';
import 'package:lomba_frontend/presentation/detailedList/bloc/detailedList_bloc.dart';
import 'package:lomba_frontend/presentation/flow/bloc/flow_bloc.dart';
import 'package:lomba_frontend/presentation/login/bloc/login_bloc.dart';
import 'package:lomba_frontend/data/datasources/orga_data_source.dart';
import 'package:lomba_frontend/domain/usecases/orgas/add_orga.dart';
import 'package:lomba_frontend/domain/usecases/sidedrawer/do_logoff.dart';
import 'package:lomba_frontend/domain/usecases/users/get_users_notin_orga.dart';
import 'package:lomba_frontend/domain/usecases/users/update_user_password.dart';
import 'package:lomba_frontend/presentation/popular/bloc/popular_bloc.dart';
import 'package:lomba_frontend/presentation/rejected/bloc/rejected_bloc.dart';
import 'package:lomba_frontend/presentation/router/bloc/router_bloc.dart';
import 'package:lomba_frontend/presentation/tobeapproved/bloc/tobeapproved_bloc.dart';
import 'package:lomba_frontend/presentation/uploaded/bloc/uploaded_bloc.dart';
import 'package:lomba_frontend/presentation/users/bloc/user_bloc.dart';
import 'package:lomba_frontend/presentation/voted/bloc/voted_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/flow_data_source.dart';
import 'data/datasources/post_data_source.dart';
import 'data/datasources/local_data_source.dart';
import 'data/repositories/flow_repository_impl.dart';
import 'data/repositories/post_repository_impl.dart';
import 'data/repositories/local_repository_impl.dart';
import 'domain/repositories/flow_repository.dart';
import 'domain/repositories/post_repository.dart';
import 'domain/repositories/local_repository.dart';
import 'domain/usecases/flow/get_flow.dart';
import 'domain/usecases/flow/get_flows.dart';
import 'domain/usecases/local/get_has_login.dart';
import 'domain/usecases/local/get_session_role.dart';
import 'domain/usecases/local/get_session_status.dart';
import 'domain/usecases/post/get_detailedlist_posts.dart';
import 'domain/usecases/stage/get_stage.dart';
import 'domain/usecases/stage/get_stages.dart';
import 'presentation/nav/bloc/nav_bloc.dart';
import 'presentation/demolist/bloc/demolist_bloc.dart';
import 'presentation/home/bloc/home_bloc.dart';
import 'data/datasources/login_data_source.dart';
import 'data/repositories/login_repository_impl.dart';
import 'domain/repositories/login_repository.dart';
import 'data/repositories/orga_repository_impl.dart';
import 'domain/repositories/orga_repository.dart';
import 'domain/usecases/orgas/add_orgauser.dart';
import 'domain/usecases/orgas/delete_orga.dart';
import 'domain/usecases/orgas/delete_orgauser.dart';
import 'domain/usecases/orgas/enable_orga.dart';
import 'domain/usecases/orgas/enable_orgauser.dart';
import 'domain/usecases/orgas/exists_orga.dart';
import 'domain/usecases/orgas/get_orga.dart';
import 'domain/usecases/orgas/get_orgas.dart';
import 'domain/usecases/orgas/get_orgasbyuser.dart';
import 'domain/usecases/orgas/get_orgausers.dart';
import 'domain/usecases/orgas/update_orga.dart';
import 'domain/usecases/orgas/update_orgauser.dart';
import 'presentation/orgas/bloc/orga_bloc.dart';
import 'presentation/orgas/bloc/orgauser_bloc.dart';
import 'presentation/profile/bloc/profile_bloc.dart';
import 'data/datasources/role_data_source.dart';
import 'data/repositories/role_repository_impl.dart';
import 'domain/repositories/role_repository.dart';
import 'domain/usecases/roles/enable_role.dart';
import 'domain/usecases/roles/get_role.dart';
import 'domain/usecases/roles/get_roles.dart';
import 'presentation/roles/bloc/role_bloc.dart';
import 'domain/usecases/sidedrawer/get_side_options.dart';
import 'presentation/sidedrawer/bloc/sidedrawer_bloc.dart';
import 'data/datasources/user_data_source.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/usecases/users/add_user.dart';
import 'domain/usecases/users/delete_user.dart';
import 'domain/usecases/users/enable_user.dart';
import 'domain/usecases/users/exists_user.dart';
import 'domain/usecases/users/get_user.dart';
import 'domain/usecases/users/get_users.dart';
import 'domain/usecases/users/update_user.dart';
import 'presentation/stage/bloc/stage_bloc.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // bloc
  locator.registerFactory(
      () => LoginBloc(locator(), locator(), locator(), locator()));
  locator.registerFactory(
      () => HomeBloc(locator(), locator(), locator(), locator(), locator(), locator()));
  locator.registerFactory(() => SideDrawerBloc(locator(), locator(), locator(),
      locator(), locator(), locator()));
  locator.registerFactory(() => NavBloc());
  locator.registerFactory(() => RouterPageBloc(locator()));
  locator.registerFactory(() => OrgaBloc(
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
      ));
  locator.registerFactory(() => RoleBloc(locator(), locator(), locator()));

  locator.registerFactory(() => OrgaUserBloc(locator(), locator(), locator(),
      locator(), locator(), locator(), locator()));

  locator.registerFactory(() => UserBloc(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator()));

  locator.registerFactory(() => ProfileBloc(locator(), locator()));
  locator.registerFactory(() => DemoListBloc());

  locator.registerFactory(() => UploadedBloc(locator(), locator(), locator(), locator(), locator()));

  locator.registerFactory(() => ApprovedBloc(locator(), locator(), locator()));

  locator.registerFactory(() => RejectedBloc(locator(), locator(), locator()));
  locator.registerFactory(() => ToBeApprovedBloc(
        locator(),
        locator(),
        locator(),
      ));
  locator
      .registerFactory(() => AddContentBloc(locator(), locator(), locator()));
  locator.registerFactory(
      () => PopularBloc(locator(), locator(), locator(), locator(), locator()));

  locator.registerFactory(
      () => VotedBloc(locator(), locator(), locator(), locator()));
  locator.registerFactory(
      () => FlowBloc(locator(), locator()));
  locator.registerFactory(
      () => StageBloc(locator(), locator()));
  locator.registerFactory(
      () => DetailedListBloc(locator(), locator(), locator(), locator()));

  // usecase
  locator.registerLazySingleton(() => UpdateUserPassword(locator()));
  locator.registerLazySingleton(() => GetAuthenticate(locator()));
  locator.registerLazySingleton(() => GetHasLogIn(locator()));
  locator.registerLazySingleton(() => GetSession(locator()));
  locator.registerLazySingleton(() => GetSessionRole(locator()));
  locator.registerLazySingleton(() => GetSideOptions(locator()));
  locator.registerLazySingleton(() => DoLogOff(locator()));
  locator.registerLazySingleton(() => RegisterUser(locator()));
  locator.registerLazySingleton(() => ChangeOrga(locator()));

  locator.registerLazySingleton(() => AddOrga(locator()));
  locator.registerLazySingleton(() => AddOrgaUser(locator()));
  locator.registerLazySingleton(() => DeleteOrga(locator()));
  locator.registerLazySingleton(() => DeleteOrgaUser(locator()));
  locator.registerLazySingleton(() => EnableOrga(locator()));
  locator.registerLazySingleton(() => EnableOrgaUser(locator()));
  locator.registerLazySingleton(() => GetOrga(locator()));
  locator.registerLazySingleton(() => GetOrgas(locator()));
  locator.registerLazySingleton(() => GetOrgaUsers(locator()));
  locator.registerLazySingleton(() => UpdateOrga(locator()));
  locator.registerLazySingleton(() => ExistsOrga(locator()));
  locator.registerLazySingleton(() => UpdateOrgaUser(locator()));
  locator.registerLazySingleton(() => GetOrgasByUser(locator()));

  locator.registerLazySingleton(() => AddUser(locator()));
  locator.registerLazySingleton(() => DeleteUser(locator()));
  locator.registerLazySingleton(() => EnableUser(locator()));
  locator.registerLazySingleton(() => GetUser(locator()));
  locator.registerLazySingleton(() => GetUsers(locator()));
  locator.registerLazySingleton(() => UpdateUser(locator()));
  locator.registerLazySingleton(() => ExistsUser(locator()));
  locator.registerLazySingleton(() => GetUsersNotInOrga(locator()));

  locator.registerLazySingleton(() => EnableRole(locator()));
  locator.registerLazySingleton(() => GetRole(locator()));
  locator.registerLazySingleton(() => GetRoles(locator()));
  locator.registerLazySingleton(() => GetAuthenticateGoogle(locator()));

  locator.registerLazySingleton(() => AddTextPost(locator()));
  locator.registerLazySingleton(() => GetApprovedPosts(locator()));
  locator.registerLazySingleton(() => GetForApprovePosts(locator()));
  locator.registerLazySingleton(() => GetLatestPosts(locator()));
  locator.registerLazySingleton(() => GetPopularPosts(locator()));
  locator.registerLazySingleton(() => GetRejectedPosts(locator()));
  locator.registerLazySingleton(() => GetUploadedPosts(locator()));
  locator.registerLazySingleton(() => GetVotedPosts(locator()));
  locator.registerLazySingleton(() => VotePublication(locator()));
  locator.registerLazySingleton(() => UpdateEdit(locator()));
  locator.registerLazySingleton(() => DeletePost(locator()));
  locator.registerLazySingleton(() => GetDetailedListPosts(locator()));

  locator.registerLazySingleton(() => GetFlow(locator()));
  locator.registerLazySingleton(() => GetFlows(locator()));

  locator.registerLazySingleton(() => GetStage(locator()));
  locator.registerLazySingleton(() => GetStages(locator()));

  // repository
  locator.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator(),
        userDataSource: locator()),
  );
  locator.registerLazySingleton<LocalRepository>(
    () => LocalRepositoryImpl(localDataSource: locator()),
  );
  locator.registerLazySingleton<OrgaRepository>(
    () => OrgaRepositoryImpl(remoteDataSource: locator()),
  );
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: locator()),
  );
  locator.registerLazySingleton<RoleRepository>(
    () => RoleRepositoryImpl(remoteDataSource: locator()),
  );
  locator.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(remoteDataSource: locator()),
  );
  locator.registerLazySingleton<FlowRepository>(
    () => FlowRepositoryImpl(remoteDataSource: locator()),
  );

  // data source
  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      client: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(
      sharedPreferences: locator(),
    ),
  );
  locator.registerLazySingleton<OrgaRemoteDataSource>(
    () => OrgaRemoteDataSourceImpl(
      client: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<UserRemoteDataSource>(
    () =>
        UserRemoteDataSourceImpl(client: locator(), localDataSource: locator()),
  );
  locator.registerLazySingleton<RoleRemoteDataSource>(
    () =>
        RoleRemoteDataSourceImpl(client: locator(), localDataSource: locator()),
  );
  locator.registerLazySingleton<PostRemoteDataSource>(
    () =>
        PostRemoteDataSourceImpl(client: locator(), localDataSource: locator()),
  );
  locator.registerLazySingleton<FlowRemoteDataSource>(
    () =>
        FlowRemoteDataSourceImpl(client: locator(), localDataSource: locator()),
  );

  // external
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => sharedPreferences);
  final firebaseAuthInstance = FirebaseAuth.instance;
  locator.registerLazySingleton(() => firebaseAuthInstance);
}
