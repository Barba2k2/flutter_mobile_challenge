import '../../../auth/data/model/user_model.dart';
import '../model/post_model.dart';

abstract class PostsDatasourceInterface {
  Future<List<PostModel>> getPosts();
  Future<PostModel> getPostById(int id);
  Future<UserModel> getUserById(int id);
}
