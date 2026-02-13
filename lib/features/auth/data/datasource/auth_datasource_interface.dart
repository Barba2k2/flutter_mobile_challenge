import '../model/user_model.dart';

abstract class AuthDatasourceInterface {
  UserModel? getCurrentUser();
  Future<UserModel> loginWithEmail(String email, String password);
  Future<UserModel> registerWithEmail(String email, String password);
  Future<UserModel> signInWithGoogle();
  Future<void> signOut();
}
