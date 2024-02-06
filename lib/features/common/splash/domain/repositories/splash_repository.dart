import 'package:healthy_app/core/domain/entities/response.dart';

abstract class SplashRepository {
  Future<void> trackingTransparencyRequest();
  Future<Response<bool>> isUserloggedIn();
}
