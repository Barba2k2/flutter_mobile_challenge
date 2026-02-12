import '../entities/post_entity.dart';
import '../repository/post_repository_interface.dart';
import '../../../../shared/typedefs.dart';

class GetPostsUseCase {
  // Injeção de dependência do repositório
  final PostRepositoryInterface repository;

  // Construtor que recebe o repositório
  GetPostsUseCase(this.repository);

  AsyncResultPosts<List<PostEntity>> call() async {
    // Função assincrona para pegar a lista de posts
    // Chama a função do repositório para pegar a lista de posts
    return await repository.getPostList();
  }
}
