import 'package:flutter/material.dart';
import 'package:flutter_practical/constants/app_pages.dart';
import 'package:flutter_practical/constants/app_routes.dart';
import 'package:flutter_practical/constants/app_strings.dart';
import 'package:flutter_practical/constants/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.homePage,
      routes: AppPages.routes,
    );
  }
}
