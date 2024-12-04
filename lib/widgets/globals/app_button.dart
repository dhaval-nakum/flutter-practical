import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

/// A reusable button widget with customizable text, padding, margin, and tap functionality.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text, // Button text.
    required this.onTap, // Callback for button tap.
    this.padding, // Optional padding around the button content.
    this.margin, // Optional margin around the button.
  });

  /// Text to be displayed on the button.
  final String text;

  /// Callback function triggered when the button is tapped.
  final VoidCallback onTap;

  /// Optional padding around the button content. Default is [EdgeInsets.symmetric(horizontal: 16, vertical: 10]
  final EdgeInsets? padding;

  /// Optional margin around the button widget.
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: margin,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          text,
          style: const TextStyle(color: AppColors.whiteColor),
        ),
      ),
    );
  }
}
