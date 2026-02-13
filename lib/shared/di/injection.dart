import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/datasource/auth_datasource_interface.dart';
import '../../features/auth/data/datasource/auth_firebase_datasource.dart';
import '../../features/auth/data/repository/auth_repository_impl.dart';
import '../../features/auth/domain/repository/auth_repository_interface.dart';
import '../../features/auth/domain/use_cases/get_current_user_use_case.dart';
import '../../features/auth/domain/use_cases/google_sign_in_use_case.dart';
import '../../features/auth/domain/use_cases/login_usecase.dart';
import '../../features/auth/domain/use_cases/register_usecase.dart';
import '../../features/auth/domain/use_cases/sign_out_use_case.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/posts/data/datasource/post_datasource_interface.dart';
import '../../features/posts/data/datasource/post_dio_datasource.dart';
import '../../features/posts/data/datasource/post_favorite_datasource_interface.dart';
import '../../features/posts/data/datasource/post_firestore_datasource.dart';
import '../../features/posts/data/repository/post_repository_impl.dart';
import '../../features/posts/domain/repository/post_repository_interface.dart';
import '../../features/posts/domain/use_cases/get_posts_by_id_use_case.dart';
import '../../features/posts/domain/use_cases/get_posts_use_case.dart';
import '../../features/posts/domain/use_cases/save_post_use_case.dart';
import '../../features/posts/presentation/bloc/post_bloc.dart';
import '../services/local_notification_service.dart';
import '../services/local_notification_service_interface.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.allowReassignment = true;

  // Firebase
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  // HTTP
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Notifications
  getIt.registerLazySingleton<LocalNotificationServiceInterface>(
    () => LocalNotificationService(),
  );

  // Auth datasource
  getIt.registerLazySingleton<AuthDatasourceInterface>(
    () => AuthFirebaseDatasource(auth: getIt<FirebaseAuth>()),
  );

  // Auth repository
  getIt.registerLazySingleton<AuthRepositoryInterface>(
    () => AuthRepositoryImpl(getIt<AuthDatasourceInterface>()),
  );

  // Auth use cases
  getIt.registerFactory(
    () => GetCurrentUserUseCase(getIt<AuthRepositoryInterface>()),
  );
  getIt.registerFactory(() => LoginUseCase(getIt<AuthRepositoryInterface>()));
  getIt.registerFactory(
    () => RegisterUseCase(getIt<AuthRepositoryInterface>()),
  );
  getIt.registerFactory(() => SignOutUseCase(getIt<AuthRepositoryInterface>()));
  getIt.registerFactory(
    () => GoogleSignInUseCase(getIt<AuthRepositoryInterface>()),
  );

  // Auth bloc
  getIt.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      getCurrentUserUseCase: getIt<GetCurrentUserUseCase>(),
      loginUseCase: getIt<LoginUseCase>(),
      registerUseCase: getIt<RegisterUseCase>(),
      signOutUseCase: getIt<SignOutUseCase>(),
      googleSignInUseCase: getIt<GoogleSignInUseCase>(),
    ),
  );

  // Posts datasources
  getIt.registerLazySingleton<PostsDatasourceInterface>(
    () => PostsDioDatasource(getIt<Dio>()),
  );
  getIt.registerLazySingleton<PostFavoriteDatasourceInterface>(
    () => PostFirestoreDatasource(
      firestore: getIt<FirebaseFirestore>(),
      auth: getIt<FirebaseAuth>(),
    ),
  );

  // Posts repository
  getIt.registerLazySingleton<PostRepositoryInterface>(
    () => PostsRepositoryImpl(
      datasource: getIt<PostsDatasourceInterface>(),
      favoriteDatasource: getIt<PostFavoriteDatasourceInterface>(),
    ),
  );

  // Posts use cases
  getIt.registerFactory(
    () => GetPostsUseCase(getIt<PostRepositoryInterface>()),
  );
  getIt.registerFactory(
    () => GetPostByIdUseCase(getIt<PostRepositoryInterface>()),
  );
  getIt.registerFactory(
    () => SavePostUseCase(getIt<PostRepositoryInterface>()),
  );

  // Posts bloc
  getIt.registerLazySingleton<PostsBloc>(
    () => PostsBloc(
      getPostsUseCase: getIt<GetPostsUseCase>(),
      getPostByIdUseCase: getIt<GetPostByIdUseCase>(),
      savePostUseCase: getIt<SavePostUseCase>(),
      notificationService: getIt<LocalNotificationServiceInterface>(),
    ),
  );
}
