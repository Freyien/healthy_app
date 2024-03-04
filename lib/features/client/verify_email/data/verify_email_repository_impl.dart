import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/features/client/verify_email/domain/repositories/verify_email_repository.dart';

class VerifyEmailRepositoryImpl implements VerifyEmailRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseCrashlytics _crashlytics;

  VerifyEmailRepositoryImpl(
    this._firebaseAuth,
    this._crashlytics,
  );

  @override
  Response<String> getEmailEvent() {
    try {
      final email = _firebaseAuth.currentUser?.email ?? '';

      return Response.success(email);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }

  @override
  Future<Response<void>> sendEmailVerification() async {
    try {
      await _firebaseAuth.currentUser?.sendEmailVerification();
      return Response.success(null);
    } catch (e, s) {
      await _crashlytics.recordError(e, s);
      return Response.failed(UnexpectedFailure());
    }
  }

  @override
  Future<Response<bool>> checkEmailVerified() async {
    try {
      final currentUser = _firebaseAuth.currentUser;

      await currentUser?.reload();
      final emailVerified = currentUser?.emailVerified ?? false;

      if (!emailVerified) return Response.success(emailVerified);

      return Response.success(emailVerified);
    } catch (e) {
      return Response.success(false);
    }
  }
}
