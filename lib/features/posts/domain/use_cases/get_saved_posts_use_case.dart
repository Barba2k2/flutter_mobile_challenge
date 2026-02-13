import '../../../../shared/typedefs.dart';
import '../entities/post_entity.dart';
import '../repository/post_repository_interface.dart';

class GetSavedPostsUseCase {
  final PostRepositoryInterface repository;

  GetSavedPostsUseCase(this.repository);

  AsyncResultPosts<List<PostEntity>> getSavedPosts() async {
    return await repository.getSavedPosts();
  }
}
