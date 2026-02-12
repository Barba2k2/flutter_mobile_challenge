import '../model/post_model.dart';

abstract class PostFavoriteDatasourceInterface {
  Future<void> savePost(PostModel post);
  Future<List<PostModel>> getSavedPosts();
}
