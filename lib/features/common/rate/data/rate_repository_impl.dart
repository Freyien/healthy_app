import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:healthy_app/features/common/rate/domain/repositories/rate_repository.dart';
import 'package:in_app_review/in_app_review.dart';

class RateRepositoryImpl implements RateRepository {
  final InAppReview _appReview;
  final FirebaseCrashlytics _crashlytics;

  RateRepositoryImpl(this._appReview, this._crashlytics);

  @override
  Future<void> requestReview() async {
    try {
      final isAvailable = await _appReview.isAvailable();
      if (!isAvailable) return;

      _appReview.requestReview();
    } catch (e, s) {
      await _crashlytics.recordError(e, s);
      return;
    }
  }
}
