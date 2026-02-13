import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/posts/presentation/bloc/post_bloc.dart';
import 'firebase_options.dart';
import 'shared/di/injection.dart';
import 'shared/router/app_router.dart';
import 'shared/services/local_notification_service_interface.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupDependencies();

  await getIt<LocalNotificationServiceInterface>().initialize();

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final _authBloc = getIt<AuthBloc>();
  late final _router = appRouter(authBloc: _authBloc);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _authBloc),
        BlocProvider.value(value: getIt<PostsBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Mobile Challenge',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: Colors.deepPurple,
          useMaterial3: true,
          brightness: Brightness.dark,
        ),
        routerConfig: _router,
      ),
    );
  }
}
