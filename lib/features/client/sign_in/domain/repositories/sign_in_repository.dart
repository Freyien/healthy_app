import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/entities/user_entity.dart';

abstract class SignInRepository {
  Future<Response<UserEntity>> loginWithEmail(
    String email,
    String password,
  );

  Future<Response<UserEntity>> signInWithGoogle();
  Future<Response<UserEntity>> signInWithApple();

  Future<void> signOut();
}
