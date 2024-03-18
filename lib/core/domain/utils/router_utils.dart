import 'package:healthy_app/core/domain/entities/initial_route_entity.dart';

class RouterUtils {
  static getLocation(InitialRoute initialRoute) {
    switch (initialRoute) {
      case InitialRoute.home:
        return '/home';
      case InitialRoute.signIn:
        return '/sign_in';
      case InitialRoute.notification:
        return '/notification_request';
      case InitialRoute.appUpdate:
        return '/app_update';
      case InitialRoute.initialConfig:
        return '/initial_config';
      case InitialRoute.notDefined:
        return '/sign_in';
    }
  }
}
