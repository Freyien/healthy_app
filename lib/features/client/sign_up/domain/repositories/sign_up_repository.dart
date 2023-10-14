import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/entities/user_entity.dart';

abstract class SignUpRepository {
  Future<Response<UserEntity>> signUpWithEmail(
    String email,
    String password,
  );

  Future<Response<UserEntity>> signUpWithGoogle();
  Future<Response<UserEntity>> signUpWithApple();
}
