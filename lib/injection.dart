import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:lomba_frontend/features/login/domain/usecases/get_authenticate.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/login_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/data/datasources/local_data_source.dart';

import 'core/data/repositories/local_repository_impl.dart';
import 'core/domain/repositories/local_repository.dart';
import 'core/domain/usecases/get_has_login.dart';
import 'core/domain/usecases/get_session_status.dart';
import 'core/presentation/bloc/nav_bloc.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
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
  locator.registerFactory(() => SideDrawerBloc(locator()));
  locator.registerFactory(() => NavBloc());

  // usecase
  locator.registerLazySingleton(() => GetAuthenticate(locator()));
  locator.registerLazySingleton(() => GetHasLogIn(locator()));
  locator.registerLazySingleton(() => GetSession(locator()));
  locator.registerLazySingleton(() => GetSideOptions(locator()));

  // repository
  locator.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
        remoteDataSource: locator(), localDataSource: locator()),
  );
  locator.registerLazySingleton<LocalRepository>(
    () => LocalRepositoryImpl(localDataSource: locator()),
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

  // external
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => sharedPreferences);
}
