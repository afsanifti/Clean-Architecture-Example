import 'package:get_it/get_it.dart';
import 'package:testingapp/src/authentication/data/datasource/authentication_remote_data_source.dart';
import 'package:testingapp/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:testingapp/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:testingapp/src/authentication/domain/usecases/create_user.dart';
import 'package:testingapp/src/authentication/domain/usecases/get_users.dart';
import 'package:testingapp/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl
    // App Logic
    ..registerFactory(
      () => AuthenticationCubit(createUser: sl(), getUsers: sl()),
    )

    // Usecases
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))

    // repositories
      // we can not register Authentication Repository
      // so we say 'Whenever someone is looking for AuthenticationRepository,'
      // 'give then AuthenticationRepositoryImplementation' as it implements
      // AuthenticationRepository
      // So now take a look
      // ``usecases`` depend of the AuthenticationRepository
      // but GetIt is injecting an AuthenticationRepositoryImplementation
    ..registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImplementation(sl()),
    )

    // Datasource
      // same goes for this
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthRemoteDataSrcImpl(sl()),
    )

    // External Dependency
      // .new will create a new instance of it
    ..registerLazySingleton(() => http.Client());
}
