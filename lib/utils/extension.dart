import 'package:flutter/material.dart';

extension ColorExtension on Color {
  Color darker() {
    const factor = 0.9;
    return Color.fromARGB(
      alpha,
      (red * factor).round(),
      (green * factor).round(),
      (blue * factor).round(),
    );
  }
}
