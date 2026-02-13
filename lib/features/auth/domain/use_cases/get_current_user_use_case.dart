import '../../../../shared/typedefs.dart';
import '../entities/user_entity.dart';
import '../repository/auth_repository_interface.dart';

class GetCurrentUserUseCase {
  final AuthRepositoryInterface repository;

  GetCurrentUserUseCase(this.repository);

  AsyncResultAuth<UserEntity> call() async {
    return await repository.getCurrentUser();
  }
}
