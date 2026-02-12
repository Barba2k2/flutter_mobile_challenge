import '../../../../shared/typedefs.dart';
import '../entities/post_entity.dart';
import '../entities/user_entity.dart';

abstract class PostRepositoryInterface {
  AsyncResultPosts<List<PostEntity>> getPostList();
  AsyncResultPosts<PostEntity> getPostById(int id);
  AsyncResultPosts<UserEntity> getUserById(int id);
  AsyncResultPosts<void> savePost(PostEntity post);
  AsyncResultPosts<List<PostEntity>> getSavedPosts();
}
