extension StringExtensions on String? {
  String leadingZero({int double = 2, String padding = '0'}) =>
      this.toString().padLeft(2, '0');

  bool get isNullOrEmpty => (this ?? '').isEmpty;
}
