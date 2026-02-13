import '../../../../shared/typedefs.dart';
import '../entities/user_entity.dart';
import '../repository/auth_repository_interface.dart';

class RegisterUseCase {
  final AuthRepositoryInterface repository;

  RegisterUseCase(this.repository);

  AsyncResultAuth<UserEntity> register(String email, String password) async {
    return await repository.registerWithEmail(email, password);
  }
}
