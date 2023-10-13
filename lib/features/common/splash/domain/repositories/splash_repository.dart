import 'package:healthy_app/core/domain/entities/response.dart';

abstract class SplashRepository {
  Future<Response<bool>> isUserloggedIn();
}
