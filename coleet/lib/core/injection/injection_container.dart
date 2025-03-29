import 'package:get_it/get_it.dart';

import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repositories_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_with_email.dart';
import '../../features/auth/domain/usecases/login_with_social.dart';
import '../../features/auth/domain/usecases/register_with_email.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/onboarding/presentation/bloc/profile_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(
        () => AuthBloc(
      loginWithEmail: sl(),
      loginWithSocial: sl(),
      registerWithEmail: sl(),
    ),
  );

  sl.registerFactory(() => ProfileBloc());

  // Use cases
  sl.registerLazySingleton(() => LoginWithEmail(sl()));
  sl.registerLazySingleton(() => LoginWithSocial(sl()));
  sl.registerLazySingleton(() => RegisterWithEmail(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(),
  );
}