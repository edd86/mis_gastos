import 'package:flutter/material.dart';
import 'package:mis_gastos/pages/home/home_page.dart';
import 'package:mis_gastos/pages/login/login_page.dart';
import 'package:mis_gastos/pages/operations/operations_page.dart';
import 'package:mis_gastos/pages/login/register_user.dart';

class AppRoutes {
  static const String loginPage = '/login';
  static const String home = '/home';
  static const String registerUser = '/register_user';
  static const String operations = '/operations';

  Map<String, WidgetBuilder> get appRoutes {
    return {
      loginPage: (context) => const LoginPage(),
      home: (context) => HomePage(),
      registerUser: (context) => const RegisterUser(),
      operations: (context) => const OperationsPage(),
    };
  }
}
