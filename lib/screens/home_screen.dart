import 'package:flutter/material.dart';
import 'package:flutter_practical/constants/app_routes.dart';
import 'package:flutter_practical/constants/app_strings.dart';
import 'package:flutter_practical/widgets/globals/app_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.home),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppButton(
              text: AppStrings.dragAndDrop,
              margin: const EdgeInsets.only(bottom: 10),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.dragAndDrop);
              },
            ),
            AppButton(
              text: AppStrings.pageFlip,
              margin: const EdgeInsets.only(bottom: 10),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.pageFlip);
              },
            ),
          ],
        ),
      ),
    );
  }
}
