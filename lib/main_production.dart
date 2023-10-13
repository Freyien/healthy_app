import 'package:healthy_app/app/app.dart';
import 'package:healthy_app/bootstrap.dart';

void main() async {
  await bootstrap(
    (initialRoute) {
      return App(initialRoute: initialRoute);
    },
  );
}
