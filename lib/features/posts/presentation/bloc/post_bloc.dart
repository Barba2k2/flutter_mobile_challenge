import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/services/local_notification_service_interface.dart';
import '../../domain/use_cases/get_posts_by_id_use_case.dart';
import '../../domain/use_cases/get_posts_use_case.dart';
import '../../domain/use_cases/save_post_use_case.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetPostsUseCase _getPostsUseCase;
  final GetPostByIdUseCase _getPostByIdUseCase;
  final SavePostUseCase _savePostUseCase;
  final LocalNotificationServiceInterface _notificationService;

  PostsBloc({
    required GetPostsUseCase getPostsUseCase,
    required GetPostByIdUseCase getPostByIdUseCase,
    required SavePostUseCase savePostUseCase,
    required LocalNotificationServiceInterface notificationService,
  }) : _getPostsUseCase = getPostsUseCase,
       _getPostByIdUseCase = getPostByIdUseCase,
       _savePostUseCase = savePostUseCase,
       _notificationService = notificationService,
       super(PostsInitial()) {
    on<LoadPostsRequested>(_onLoadPosts);
    on<LoadPostByIdRequested>(_onLoadPostById);
    on<SavePostRequested>(_onSavePost);
  }

  Future<void> _onLoadPosts(
    LoadPostsRequested event,
    Emitter<PostsState> emit,
  ) async {
    emit(PostsLoading());

    final result = await _getPostsUseCase.getPosts();

    result.fold(
      (error) => emit(
        PostsError(error.toString()),
      ),
      (posts) {
        emit(PostsLoaded(posts));
        _notificationService.showNotification(
          title: 'Posts carregados',
          body: '${posts.length} posts carregados',
        );
      },
    );
  }

  Future<void> _onLoadPostById(
    LoadPostByIdRequested event,
    Emitter<PostsState> emit,
  ) async {
    emit(PostsLoading());

    final result = await _getPostByIdUseCase.getPostById(event.id);

    result.fold(
      (error) => emit(
        PostsError(error.toString()),
      ),
      (post) => emit(
        PostDetailLoaded(post),
      ),
    );
  }

  Future<void> _onSavePost(
    SavePostRequested event,
    Emitter<PostsState> emit,
  ) async {
    final result = await _savePostUseCase.savePost(event.post);

    result.fold(
      (error) => emit(PostsError(error.toString())),
      (_) => _notificationService.showNotification(
        title: 'Post salvo',
        body: 'Post salvo nos seus favoritos',
      ),
    );
  }
}
