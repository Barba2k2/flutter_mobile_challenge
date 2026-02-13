import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/get_posts_by_id_use_case.dart';
import '../../domain/use_cases/get_posts_use_case.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetPostsUseCase _getPostsUseCase;
  final GetPostByIdUseCase _getPostByIdUseCase;

  PostsBloc({
    required GetPostsUseCase getPostsUseCase,
    required GetPostByIdUseCase getPostByIdUseCase,
  }) : _getPostsUseCase = getPostsUseCase,
       _getPostByIdUseCase = getPostByIdUseCase,
       super(PostsInitial()) {
    on<LoadPostsRequested>(_onLoadPosts);
    on<LoadPostByIdRequested>(_onLoadPostById);
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
      (posts) => emit(
        PostsLoaded(posts),
      ),
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
}
