import '../../../../shared/typedefs.dart';
import '../entities/user_entity.dart';
import '../repository/post_repository_interface.dart';

class GetUserUseCase {
  final PostRepositoryInterface repository;

  GetUserUseCase(this.repository);

  AsyncResultPosts<UserEntity> getUserById(int id) async {
    return await repository.getUserById(id);
  }
}
