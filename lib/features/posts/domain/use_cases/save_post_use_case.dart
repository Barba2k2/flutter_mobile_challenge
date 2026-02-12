/*
class SavePostUseCase {
  final PostRepositoryInterface repository; //Injeção de dependência do repositório

  SavePostUseCase(this.repository); //Construtor que recebe o repositório

  AsyncResultPosts<void> call(PostEntity post) async { //Função assincrona para salvar um post
    if (!post.isValid()) { //Verifica se o post é válido
      return Left(Exception('Post inválido')); //Retorna uma exceção caso o post seja inválido
    }
    return await repository.savePost(post); //Chama a função do repositório para salvar o post
  }
}*/ //Descomente este código quando o repositório suportar salvamento de posts no firebase
