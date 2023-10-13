abstract class AnalyticsRepository {
  Future<void> setDefaultEventParameters();
  Future<void> logEvent(String eventName, Map<String, dynamic> parameters);
}
