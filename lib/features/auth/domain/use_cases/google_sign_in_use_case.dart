import '../../../../shared/typedefs.dart';
import '../entities/user_entity.dart';
import '../repository/auth_repository_interface.dart';

class GoogleSignInUseCase {
  final AuthRepositoryInterface repository;

  GoogleSignInUseCase(this.repository);

  AsyncResultAuth<UserEntity> signIn() async {
    return await repository.signInWithGoogle();
  }
}
