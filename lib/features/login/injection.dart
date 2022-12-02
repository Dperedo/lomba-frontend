import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:lomba_frontend/features/login/data/repositories/localcache_repository_impl.dart';
import 'package:lomba_frontend/features/login/domain/usecases/get_authenticate.dart';
import 'package:lomba_frontend/features/login/domain/usecases/validate_login.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/home_bloc.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/login_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/localcache_data_source.dart';
import 'data/datasources/remote_data_source.dart';
import 'data/repositories/login_repository_impl.dart';
import 'domain/repositories/localcache_repository.dart';
import 'domain/repositories/login_repository.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // bloc
  locator.registerFactory(() => LoginBloc(locator()));
  locator.registerFactory(() => HomeBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => GetAuthenticate(locator()));
  locator.registerLazySingleton(() => ValidateLogin(locator()));

  // repository
  locator.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
        remoteDataSource: locator(), localCacheDataSource: locator()),
  );
  locator.registerLazySingleton<LocalCacheRepository>(
    () => LocalCacheRepositoryImpl(localDataSource: locator()),
  );

  // data source
  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      client: locator(),
    ),
  );
  locator.registerLazySingleton<LocalCacheDataSource>(
    () => LoginLocalDataSourceImpl(
      sharedPreferences: locator(),
    ),
  );

  // external
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => sharedPreferences);
}
