import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:lomba_frontend/domain/usecases/login/readif_redirect_login.dart';
import 'package:lomba_frontend/domain/usecases/login/start_redirect_login.dart';
import 'package:lomba_frontend/domain/usecases/post/add_multi_post.dart';
import 'package:lomba_frontend/domain/usecases/post/add_text_post.dart';
import 'package:lomba_frontend/domain/usecases/post/change_stage_post.dart';
import 'package:lomba_frontend/domain/usecases/post/delete_post.dart';
import 'package:lomba_frontend/domain/usecases/post/enable_post.dart';
import 'package:lomba_frontend/domain/usecases/post/get_approved_posts.dart';
import 'package:lomba_frontend/domain/usecases/post/get_for_approve_posts.dart';
import 'package:lomba_frontend/domain/usecases/post/get_latest_posts.dart';
import 'package:lomba_frontend/domain/usecases/post/get_popular_posts.dart';
import 'package:lomba_frontend/domain/usecases/post/get_post.dart';
import 'package:lomba_frontend/domain/usecases/post/get_rejected_posts.dart';
import 'package:lomba_frontend/domain/usecases/post/get_uploaded_posts.dart';
import 'package:lomba_frontend/domain/usecases/post/get_voted_posts.dart';
import 'package:lomba_frontend/domain/usecases/post/update_edit.dart';
import 'package:lomba_frontend/domain/usecases/post/vote_publication.dart';
import 'package:lomba_frontend/domain/usecases/login/change_orga.dart';
import 'package:lomba_frontend/domain/usecases/login/get_authenticate.dart';
import 'package:lomba_frontend/domain/usecases/login/get_authenticate_google.dart';
import 'package:lomba_frontend/domain/usecases/login/register_user.dart';
import 'package:lomba_frontend/domain/usecases/storage/get_cloudfile.dart';
import 'package:lomba_frontend/domain/usecases/storage/register_cloudfile.dart';
import 'package:lomba_frontend/domain/usecases/storage/upload_cloudfile.dart';
import 'package:lomba_frontend/presentation/addcontent/bloc/addcontent_bloc.dart';
import 'package:lomba_frontend/presentation/approved/bloc/approved_bloc.dart';
import 'package:lomba_frontend/presentation/detailed_list/bloc/detailed_list_bloc.dart';
import 'package:lomba_frontend/presentation/favorites/bloc/favorites_bloc.dart';
import 'package:lomba_frontend/presentation/flow/bloc/flow_bloc.dart';
import 'package:lomba_frontend/presentation/login/bloc/login_bloc.dart';
import 'package:lomba_frontend/data/datasources/orga_data_source.dart';
import 'package:lomba_frontend/domain/usecases/orgas/add_orga.dart';
import 'package:lomba_frontend/domain/usecases/sidedrawer/do_logoff.dart';
import 'package:lomba_frontend/domain/usecases/users/get_users_notin_orga.dart';
import 'package:lomba_frontend/domain/usecases/users/update_user_password.dart';
import 'package:lomba_frontend/presentation/popular/bloc/popular_bloc.dart';
import 'package:lomba_frontend/presentation/post/bloc/post_bloc.dart';
import 'package:lomba_frontend/presentation/rejected/bloc/rejected_bloc.dart';
import 'package:lomba_frontend/presentation/router/bloc/router_bloc.dart';
import 'package:lomba_frontend/presentation/saved/bloc/saved_bloc.dart';
import 'package:lomba_frontend/presentation/setting_admin/bloc/setting_admin_bloc.dart';
import 'package:lomba_frontend/presentation/setting_super/bloc/setting_super_bloc.dart';
import 'package:lomba_frontend/presentation/tobeapproved/bloc/tobeapproved_bloc.dart';
import 'package:lomba_frontend/presentation/uploaded/bloc/uploaded_bloc.dart';
import 'package:lomba_frontend/presentation/users/bloc/user_bloc.dart';
import 'package:lomba_frontend/presentation/voted/bloc/voted_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/flow_data_source.dart';
import 'data/datasources/post_data_source.dart';
import 'data/datasources/local_data_source.dart';
import 'data/datasources/setting_data_source.dart';
import 'data/datasources/stage_data_source.dart';
import 'data/datasources/storage_data_source.dart';
import 'data/repositories/flow_repository_impl.dart';
import 'data/repositories/post_repository_impl.dart';
import 'data/repositories/local_repository_impl.dart';
import 'data/repositories/setting_repository_impl.dart';
import 'data/repositories/stage_repository_impl.dart';
import 'data/repositories/storage_repository_impl.dart';
import 'domain/repositories/flow_repository.dart';
import 'domain/repositories/post_repository.dart';
import 'domain/repositories/local_repository.dart';
import 'domain/repositories/setting_repository.dart';
import 'domain/repositories/stage_repository.dart';
import 'domain/repositories/storage_repository.dart';
import 'domain/usecases/flow/get_flow.dart';
import 'domain/usecases/flow/get_flows.dart';
import 'domain/usecases/local/get_has_login.dart';
import 'domain/usecases/local/get_session_role.dart';
import 'domain/usecases/local/get_session_status.dart';
import 'domain/usecases/orgas/get_orgauser.dart';
import 'domain/usecases/post/get_detailedlist_posts.dart';
import 'domain/usecases/post/get_favorites_posts.dart';
import 'domain/usecases/post/get_saved_posts.dart';
import 'domain/usecases/post/get_withuser_post.dart';
import 'domain/usecases/setting/get_setting_admin.dart';
import 'domain/usecases/setting/get_setting_super.dart';
import 'domain/usecases/setting/updated_setting_admin.dart';
import 'domain/usecases/setting/updated_setting_super.dart';
import 'domain/usecases/stage/get_stage.dart';
import 'domain/usecases/stage/get_stages.dart';
import 'domain/usecases/storage/register_cloudfile_profile.dart';
import 'domain/usecases/storage/upload_cloudfile_profile.dart';
import 'domain/usecases/users/exists_profile.dart';
import 'domain/usecases/users/update_profile.dart';
import 'domain/usecases/users/update_profile_password.dart';
import 'presentation/nav/bloc/nav_bloc.dart';
import 'presentation/demolist/bloc/demolist_bloc.dart';
import 'presentation/recent/bloc/recent_bloc.dart';
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
      () => LoginBloc(locator(), locator(), locator(), locator(), locator()));
  locator.registerFactory(() => RecentBloc(locator(), locator(), locator(),
      locator(), locator(), locator(), locator()));
  locator.registerFactory(() => SideDrawerBloc(
      locator(), locator(), locator(), locator(), locator(), locator()));
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
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
      ));

  locator.registerFactory(() => ProfileBloc(
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
      ));
  locator.registerFactory(() => DemoListBloc());

  locator.registerFactory(() =>
      UploadedBloc(locator(), locator(), locator(), locator(), locator()));

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
  locator.registerFactory(() => FlowBloc(locator(), locator()));
  locator.registerFactory(() => StageBloc(locator(), locator()));
  locator.registerFactory(() => SettingSuperBloc(
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
      ));
  locator.registerFactory(() => SettingAdminBloc(
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
      ));
  locator.registerFactory(() => DetailedListBloc(
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
      ));
  locator.registerFactory(() => PostBloc(
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
      ));
  locator.registerFactory(
      () => FavoritesBloc(locator(), locator(), locator(), locator()));
  locator.registerFactory(
      () => SavedBloc(locator(), locator(), locator(), locator()));

  // usecase
  locator.registerLazySingleton(() => UpdateUserPassword(locator()));
  locator.registerLazySingleton(() => UpdateProfilePassword(locator()));
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
  locator.registerLazySingleton(() => GetOrgaUser(locator()));
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
  locator.registerLazySingleton(() => UpdateProfile(locator()));
  locator.registerLazySingleton(() => ExistsProfile(locator()));
  locator.registerLazySingleton(() => GetUsersNotInOrga(locator()));

  locator.registerLazySingleton(() => EnableRole(locator()));
  locator.registerLazySingleton(() => GetRole(locator()));
  locator.registerLazySingleton(() => GetRoles(locator()));
  locator.registerLazySingleton(() => GetAuthenticateGoogle(locator()));

  locator.registerLazySingleton(() => AddTextPost(locator()));
  locator.registerLazySingleton(() => AddMultiPost(locator()));
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
  locator.registerLazySingleton(() => EnablePost(locator()));
  locator.registerLazySingleton(() => ChangeStagePost(locator()));
  locator.registerLazySingleton(() => GetPost(locator()));
  locator.registerLazySingleton(() => GetWithUserPost(locator()));
  locator.registerLazySingleton(() => GetFavoritesPosts(locator()));
  locator.registerLazySingleton(() => GetSavedPosts(locator()));

  locator.registerLazySingleton(() => GetFlow(locator()));
  locator.registerLazySingleton(() => GetFlows(locator()));

  locator.registerLazySingleton(() => GetStage(locator()));
  locator.registerLazySingleton(() => GetStages(locator()));

  locator.registerLazySingleton(() => GetSettingSuper(locator()));
  locator.registerLazySingleton(() => GetSettingAdmin(locator()));
  locator.registerLazySingleton(() => UpdatedSettingSuper(locator()));
  locator.registerLazySingleton(() => UpdatedSettingAdmin(locator()));

  locator.registerLazySingleton(() => ReadIfRedirectLogin(locator()));
  locator.registerLazySingleton(() => StartRedirectLogin(locator()));

  locator.registerLazySingleton(() => UploadFile(locator()));
  locator.registerLazySingleton(() => UploadFileProfile(locator()));
  locator.registerLazySingleton(() => GetCloudFile(locator()));
  locator.registerLazySingleton(() => RegisterCloudFile(locator()));
  locator.registerLazySingleton(() => RegisterCloudFileProfile(locator()));

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
  locator.registerLazySingleton<StageRepository>(
    () => StageRepositoryImpl(remoteDataSource: locator()),
  );
  locator.registerLazySingleton<StorageRepository>(
      () => StorageRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<SettingRepository>(
    () => SettingRepositoryImpl(remoteDataSource: locator()),
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
  locator.registerLazySingleton<StageRemoteDataSource>(() =>
      StageRemoteDataSourceImpl(client: locator(), localDataSource: locator()));

  locator.registerLazySingleton<StorageRemoteDataSource>(() =>
      StorageRemoteDataSourceImpl(
          client: locator(), localDataSource: locator()));

  locator.registerLazySingleton<SettingRemoteDataSource>(() =>
      SettingRemoteDataSourceImpl(
          client: locator(), localDataSource: locator()));

  // external
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => sharedPreferences);
  final firebaseAuthInstance = FirebaseAuth.instance;
  locator.registerLazySingleton(() => firebaseAuthInstance);
}
