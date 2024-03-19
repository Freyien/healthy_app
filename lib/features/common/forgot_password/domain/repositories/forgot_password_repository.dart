import 'package:healthy_app/core/domain/entities/response.dart';

abstract class ForgotPasswordRepository {
  Future<Response<void>> sendPasswordResetEmail(String email);
}
