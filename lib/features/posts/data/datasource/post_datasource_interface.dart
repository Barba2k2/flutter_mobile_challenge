import '../model/post_model.dart';
import '../model/user_model.dart';

abstract class PostsDatasourceInterface {
  Future<List<PostModel>> getPosts();
  Future<PostModel> getPostById(int id);
  Future<UserModel> getUserById(int id);
}
