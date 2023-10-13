extension StringExtension on String {
  /// Uppercase first letter
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}
