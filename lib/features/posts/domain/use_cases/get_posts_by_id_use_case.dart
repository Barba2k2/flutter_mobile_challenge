import '../../../../shared/typedefs.dart';

import '../entities/post_entity.dart';
import '../repository/post_repository_interface.dart';

class GetPostByIdUseCase {
  // Injeção de dependência do repositório
  final PostRepositoryInterface repository;

  // Construtor que recebe o repositório
  GetPostByIdUseCase(this.repository);

  AsyncResultPosts<PostEntity> call(int id) async {
    // Função assincrona para pegar um post pelo ID
    // Chama a função do repositório para pegar o post pelo ID
    return await repository.getPostById(
      id,
    );
  }
}
