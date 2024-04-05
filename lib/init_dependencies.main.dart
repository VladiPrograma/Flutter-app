part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initActuation();
LocalDatabase database=LocalDatabase.instance;
database.database;


  // core
  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );

}

void _initAuth() {
  // Datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
      ),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )
    // Use cases
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );


}

void _initActuation() {
  // Datasource
  serviceLocator
  // Datasource
    ..registerFactory<ActuationLocalDataSource>(
          () => ActuationLocalDataSourceImpl(
      ),
    )..registerFactory<CommentLocalDataSource>(
        () => CommentLocalDataSourceImpl(
    ),
  )..registerFactory<MediaLocalDataSource>(
        () => MediaLocalDataSourceImpl(
    ),
  )
  // Repository
    ..registerFactory<ActuationRepository>(
          () => ActuationRepositoryImpl(
        serviceLocator(),
      ),
    )..registerFactory<CommentRepository>(
        () => CommentRepositoryImpl(
      serviceLocator(),
    ),
  )..registerFactory<MediaRepository>(
        () => MediaRepositoryImpl(
      serviceLocator(),
    ),
  )
  // Usecases
    ..registerFactory(
          () => CreateActuation(
        serviceLocator(),
      ),
    )..registerFactory(
        () => UpdateActuation(
      serviceLocator(),
    ),
  )..registerFactory(
        () => GetAllActuation(
      serviceLocator(),
    ),
  )..registerFactory(
        () => DeleteActuation(
      serviceLocator(),
    ),
  )


    ..registerFactory(
          () => CreateComment(
        serviceLocator(),
      ),
    )..registerFactory(
        () => UpdateComment(
      serviceLocator(),
    ),
  )..registerFactory(
        () => GetAllComments(
      serviceLocator(),
    ),
  )..registerFactory(
        () => DeleteComment(
      serviceLocator(),
    ),
  )
    ..registerFactory(
          () => CreateMedia(
        serviceLocator(),
      ),
    )..registerFactory(
        () => UpdateMedia(
      serviceLocator(),
    ),
  )..registerFactory(
        () => GetAllMedias(
      serviceLocator(),
    ),
  )..registerFactory(
        () => DeleteMedia(
      serviceLocator(),
    ),
  )

      ;

}

