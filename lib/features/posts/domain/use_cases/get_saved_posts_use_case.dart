/*
class GetSavedPostsUseCase {
  final PostRepositoryInterface repository; //Injeção de dependência do repositório

  GetSavedPostsUseCase(this.repository); //Construtor que recebe o repositório

  AsyncResultPosts<List<PostEntity>> call() async { //Função assincrona para pegar a lista de posts
    return await repository.getSavedPosts(); //Chama a função do repositório para pegar a lista de posts salvos
  }
}*/ //Descomente este código quando o repositório suportar posts salvos no firebase
