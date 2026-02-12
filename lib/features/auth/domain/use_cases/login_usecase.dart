import '../repository/auth_repository_interface.dart';

class LoginUseCase {
  final AuthRepositoryInterface repository;

  LoginUseCase(this.repository);

  Future call() async {
    //Chama a função do repositório para fazer login do usuário
    return await repository.loginUser();
  }
}
