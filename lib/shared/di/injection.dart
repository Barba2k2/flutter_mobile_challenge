import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../features/posts/data/datasource/post_datasource_interface.dart';
import '../../features/posts/data/datasource/post_dio_datasource.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Registre dependências base
  getIt.registerLazySingleton<http.Client>(() => http.Client());
  getIt.registerLazySingleton<Dio>(() => Dio());

  // ESCOLHA AQUI: Comente/descomente para trocar
  getIt.registerLazySingleton<PostsDatasourceInterface>(
    () => PostsDioDatasource(getIt<Dio>()), // Para Dio
  );

  // Registre repositório, use cases, etc., usando PostsDatasourceInterface
}
