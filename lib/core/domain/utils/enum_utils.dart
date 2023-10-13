import 'package:collection/collection.dart';

class EnumUtils {
  static T? stringToEnum<T>(List<T> enumValues, String value) {
    return enumValues.firstWhereOrNull((element) {
      final splitEnum = element.toString().split('.').last;
      return splitEnum.toLowerCase() == value.toLowerCase();
    });
  }
}
