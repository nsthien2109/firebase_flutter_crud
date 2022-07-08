import 'package:firebase_todo/screen/create/create_todo.dart';
import 'package:firebase_todo/screen/home/home_screen.dart';
import 'package:firebase_todo/screen/login/login_screen.dart';
import 'package:firebase_todo/screen/update/update_task.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String mainRouter= '/';
  static const String loginRoute= '/login';
  static const String createRoute= '/create';
  static const String updateRoute = '/update';

    static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainRouter:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => HomeScreen(),
        );
      case loginRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => LoginScreen(),
        );    
      case createRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => CreateTodo(),
        ); 
      case updateRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const UpdateTodo(),
        );   
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const BackButton(),
        );
    }
  }
}