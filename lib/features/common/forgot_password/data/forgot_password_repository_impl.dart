import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/features/common/forgot_password/domain/repositories/forgot_password_repository.dart';

class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final FirebaseAuth _auth;
  final FirebaseCrashlytics _crashlytics;

  ForgotPasswordRepositoryImpl(this._auth, this._crashlytics);

  @override
  Future<Response<void>> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return Response.success(null);
    } catch (e, s) {
      await _crashlytics.recordError(e, s);
      return Response.failed(UnexpectedFailure());
    }
  }
}
