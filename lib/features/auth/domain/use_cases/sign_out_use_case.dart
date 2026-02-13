import '../../../../shared/typedefs.dart';
import '../repository/auth_repository_interface.dart';

class SignOutUseCase {
  final AuthRepositoryInterface repository;

  SignOutUseCase(this.repository);

  AsyncResultAuth<void> signOut() async {
    return await repository.signOut();
  }
}
