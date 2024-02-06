import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/features/common/splash/domain/repositories/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository {
  SplashRepositoryImpl(this._firebaseAuth, this._crashlytics);

  final FirebaseAuth _firebaseAuth;
  final FirebaseCrashlytics _crashlytics;

  @override
  Future<void> trackingTransparencyRequest() async {
    try {
      if (!Platform.isIOS) return;

      final status = await AppTrackingTransparency.trackingAuthorizationStatus;

      if (status == TrackingStatus.notDetermined) {
        await AppTrackingTransparency.requestTrackingAuthorization();
      }
    } catch (e, s) {
      await _crashlytics.recordError(e, s);
    }
  }

  @override
  Future<Response<bool>> isUserloggedIn() async {
    try {
      final user = _firebaseAuth.currentUser;

      user?.reload();

      final isUserloggedIn = user != null;
      if (isUserloggedIn) {
        _crashlytics.setUserIdentifier(user.uid);
      }

      return Response.success(isUserloggedIn);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }
}
