extension IntExtensions on int {
  String leadingZero({int double = 2, String padding = '0'}) =>
      this.toString().padLeft(2, '0');
}
