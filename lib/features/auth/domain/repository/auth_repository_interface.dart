import '../../../../shared/typedefs.dart';
import '../entities/user_entity.dart';

abstract class AuthRepositoryInterface {
  AsyncResultAuth<UserEntity> getCurrentUser();
  AsyncResultAuth<UserEntity> loginWithEmail(String email, String password);
  AsyncResultAuth<UserEntity> registerWithEmail(String email, String password);
  AsyncResultAuth<UserEntity> signInWithGoogle();
  AsyncResultAuth<void> signOut();
}
