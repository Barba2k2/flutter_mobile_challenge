import '../entities/post_entity.dart';
import '../../../../shared/typedefs.dart';

abstract class PostRepositoryInterface {
  AsyncResultPosts<List<PostEntity>> getPostList();
  AsyncResultPosts<PostEntity> getPostById(int id);
  //AsyncResultPosts<void> savePost(PostEntity post);
  //AsyncResultPosts<List<PostEntity>> getSavedPosts();
}
