import 'package:healthy_app/core/domain/entities/response.dart';

abstract class VerifyEmailRepository {
  Response<String> getEmailEvent();
  Future<Response<void>> sendEmailVerification();
  Future<Response<bool>> checkEmailVerified();
}
