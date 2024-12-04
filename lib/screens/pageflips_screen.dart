import 'package:flutter/material.dart';
import 'package:flutter_practical/constants/app_strings.dart';

class PageFlipScreen extends StatelessWidget {
  const PageFlipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.pageFlip),
      ),
      body: const Center(
        child: Text(AppStrings.pageFlip),
      ),
    );
  }
}
