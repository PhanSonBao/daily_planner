import 'route_constants.dart';
import 'screen_export.dart';

import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case welcomeScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const WelcomeScreen(),
      );

    case logInScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );

      case taskListScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const TaskListScreen(),
      );

      case addNewTaskScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const AddNewTaskScreen(),
      );

      case homePageScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );

      default:
      return MaterialPageRoute(
        builder: (context) => const WelcomeScreen(),
      );
  }
}