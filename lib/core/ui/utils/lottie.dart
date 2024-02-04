import 'package:collection/collection.dart';
import 'package:lottie/lottie.dart';

class LottieUtils {
  static Future<LottieComposition?> decoder(List<int> bytes) {
    return LottieComposition.decodeZip(bytes, filePicker: (files) {
      return files.firstWhereOrNull(
          (f) => f.name.startsWith('animations/') && f.name.endsWith('.json'));
    });
  }
}
