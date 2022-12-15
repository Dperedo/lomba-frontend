import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:lomba_frontend/features/login/domain/usecases/get_authenticate.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/login_bloc.dart';
import 'package:lomba_frontend/features/orgas/data/datasources/orga_remote_data_source.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/add_orga.dart';
import 'package:lomba_frontend/features/sidedrawer/domain/usecases/do_logoff.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/data/datasources/local_data_source.dart';

import 'core/data/repositories/local_repository_impl.dart';
import 'core/domain/repositories/local_repository.dart';
import 'core/domain/usecases/get_has_login.dart';
import 'core/domain/usecases/get_session_status.dart';
import 'core/presentation/bloc/nav_bloc.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/orgas/data/repositories/orga_repository_impl.dart';
import 'features/orgas/domain/repositories/orga_repository.dart';
import 'features/orgas/domain/usecases/add_orgauser.dart';
import 'features/orgas/domain/usecases/delete_orga.dart';
import 'features/orgas/domain/usecases/delete_orgauser.dart';
import 'features/orgas/domain/usecases/enable_orga.dart';
import 'features/orgas/domain/usecases/enable_orgauser.dart';
import 'features/orgas/domain/usecases/get_orga.dart';
import 'features/orgas/domain/usecases/get_orgas.dart';
import 'features/orgas/domain/usecases/get_orgausers.dart';
import 'features/orgas/domain/usecases/update_orga.dart';
import 'features/orgas/domain/usecases/update_orgauser.dart';
import 'features/orgas/presentation/bloc/orga_bloc.dart';
import 'features/sidedrawer/domain/usecases/get_side_options.dart';
import 'features/login/data/datasources/remote_data_source.dart';
import 'features/login/data/repositories/login_repository_impl.dart';
import 'features/login/domain/repositories/login_repository.dart';
import 'features/sidedrawer/presentation/bloc/sidedrawer_bloc.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // bloc
  locator.registerFactory(() => LoginBloc(locator()));
  locator.registerFactory(() => HomeBloc(locator()));
  locator.registerFactory(() => SideDrawerBloc(locator(), locator()));
  locator.registerFactory(() => NavBloc());
  locator.registerFactory(() => OrgaBloc(
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
      locator()));

  // usecase
  locator.registerLazySingleton(() => GetAuthenticate(locator()));
  locator.registerLazySingleton(() => GetHasLogIn(locator()));
  locator.registerLazySingleton(() => GetSession(locator()));
  locator.registerLazySingleton(() => GetSideOptions(locator()));
  locator.registerLazySingleton(() => DoLogOff(locator()));

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
  locator.registerLazySingleton(() => UpdateOrgaUser(locator()));

  // repository
  locator.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
        remoteDataSource: locator(), localDataSource: locator()),
  );
  locator.registerLazySingleton<LocalRepository>(
    () => LocalRepositoryImpl(localDataSource: locator()),
  );
  locator.registerLazySingleton<OrgaRepository>(
    () => OrgaRepositoryImpl(remoteDataSource: locator()),
  );

  // data source
  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      client: locator(),
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
    ),
  );

  // external
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => sharedPreferences);
}
