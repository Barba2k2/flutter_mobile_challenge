import 'package:dartz/dartz.dart';
import '../datasource/post_datasource_interface.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/repository/post_repository_interface.dart'; // Sua interface
import '../../../../shared/typedefs.dart'; // AsyncResultPosts

class PostsRepositoryImpl implements PostRepositoryInterface {
  final PostsDatasourceInterface datasource;

  PostsRepositoryImpl(this.datasource);

  @override
  AsyncResultPosts<List<PostEntity>> getPostList() async {
    try {
      // Chama datasource
      final models = await datasource.getPosts();
      // Converte models em entidades
      final entities = models.map((model) => model.toEntity()).toList();
      // Sucesso: Right com dados
      return Right(entities);
    } catch (e) {
      // Erro: Left com Exception
      return Left(
        Exception('Erro ao buscar posts: $e'),
      );
    }
  }

  @override
  AsyncResultPosts<PostEntity> getPostById(int id) async {
    try {
      final model = await datasource.getPostById(id);
      final entity = model.toEntity();
      return Right(entity);
    } catch (e) {
      return Left(
        Exception('Erro ao buscar post: $e'),
      );
    }
  }

  /*@override
  AsyncResultPosts<void> savePost(PostEntity post) async {
    // Para salvamento, assuma que datasource tem método (adicione se necessário)
    try {
      final model = PostModel(
        id: post.id,
        userId: post.userId,
        title: post.title,
        body: post.body,
      );
      await datasource.savePost(model); // Chama datasource
      return Right(null); // Sucesso: Right com void
    } catch (e) {
      return Left(Exception('Erro ao salvar post: $e'),);
    }
  }

  @override
  AsyncResultPosts<List<PostEntity>> getSavedPosts() async {
    try {
      final models = await datasource.getSavedPosts();
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(Exception('Erro ao buscar posts salvos: $e'),);
    }
  }*/ //Comentado pois o datasource não tem esses métodos, irei descomentar quando implementar salvamento no firebase
}
