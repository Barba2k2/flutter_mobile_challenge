import 'package:dartz/dartz.dart';

import '../../../../shared/typedefs.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repository/post_repository_interface.dart';
import '../datasource/post_datasource_interface.dart';
import '../datasource/post_favorite_datasource_interface.dart';
import '../model/post_model.dart';

class PostsRepositoryImpl implements PostRepositoryInterface {
  final PostsDatasourceInterface datasource;
  final PostFavoriteDatasourceInterface favoriteDatasource;

  PostsRepositoryImpl({
    required this.datasource,
    required this.favoriteDatasource,
  });

  @override
  AsyncResultPosts<List<PostEntity>> getPostList() async {
    try {
      final models = await datasource.getPosts();
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(Exception('Erro ao buscar posts: $e'));
    }
  }

  @override
  AsyncResultPosts<PostEntity> getPostById(int id) async {
    try {
      final model = await datasource.getPostById(id);
      return Right(model.toEntity());
    } catch (e) {
      return Left(Exception('Erro ao buscar post: $e'));
    }
  }

  @override
  AsyncResultPosts<UserEntity> getUserById(int id) async {
    try {
      final model = await datasource.getUserById(id);
      return Right(model.toEntity());
    } catch (e) {
      return Left(Exception('Erro ao buscar usuário: $e'));
    }
  }

  @override
  AsyncResultPosts<void> savePost(PostEntity post) async {
    try {
      final model = PostModel(
        id: post.id,
        userId: post.userId,
        title: post.title,
        body: post.body,
      );
      await favoriteDatasource.savePost(model);
      return const Right(null);
    } catch (e) {
      return Left(Exception('Erro ao salvar post: $e'));
    }
  }

  @override
  AsyncResultPosts<List<PostEntity>> getSavedPosts() async {
    try {
      final models = await favoriteDatasource.getSavedPosts();
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(Exception('Erro ao buscar posts salvos: $e'));
    }
  }
}
