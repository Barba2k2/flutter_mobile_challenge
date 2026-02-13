import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/posts/domain/entities/post_entity.dart';
import '../../features/posts/domain/entities/user_entity.dart';
import '../../features/posts/presentation/pages/author_profile_page.dart';
import '../../features/posts/presentation/pages/post_detail_page.dart';
import '../../features/posts/presentation/pages/post_page.dart';
import 'go_router_refresh_stream.dart';

GoRouter appRouter({required AuthBloc authBloc}) {
  return GoRouter(
    initialLocation: '/login',
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final isAuthenticated = authBloc.state is Authenticated;
      final location = state.matchedLocation;
      final isAuthRoute = location == '/login' || location == '/register';

      if (!isAuthenticated && !isAuthRoute) return '/login';
      if (isAuthenticated && isAuthRoute) return '/feed';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/feed',
        builder: (context, state) => const PostPage(),
      ),
      GoRoute(
        path: '/post/:id',
        builder: (context, state) {
          final post = state.extra! as PostEntity;
          return PostDetailPage(post: post);
        },
      ),
      GoRoute(
        path: '/author/:id',
        builder: (context, state) {
          final user = state.extra! as UserEntity;
          return AuthorProfilePage(user: user);
        },
      ),
    ],
  );
}
