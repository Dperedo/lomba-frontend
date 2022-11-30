import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:lomba_frontend/features/login/domain/usecases/get_authenticate.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/login_bloc.dart';

import 'data/datasources/remote_data_source.dart';
import 'data/repositories/login_repository_impl.dart';
import 'domain/repositories/login_repository.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => LoginBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => GetAuthenticate(locator()));

  // repository
  locator.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // data source
  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
}
