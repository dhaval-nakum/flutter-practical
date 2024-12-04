import 'package:flutter/material.dart';

import '../screens/dragndrop_screen.dart';
import '../screens/home_screen.dart';
import '../screens/page_flip_screen.dart';
import 'app_routes.dart';

// A class to manage all the application's routes and their corresponding screens.
class AppPages {
  // A map of route names to their respective widget builders.
  static final Map<String, WidgetBuilder> routes = {
    AppRoutes.homePage: (context) => const HomePage(),
    AppRoutes.dragAndDrop: (context) => const DragAndDropPage(),
    AppRoutes.pageFlip: (context) => const PageFlipScreen(),
  };
}
