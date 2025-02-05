import 'package:flutter/material.dart';
import 'package:mis_gastos/provider/transaction_provider.dart';
import 'package:mis_gastos/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<TransactionProvider>(
      create: (_) => TransactionProvider(),
    ),
    ChangeNotifierProvider<UserProvider>(
      create: (_) => UserProvider(),
    )
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mis Gastos',
      debugShowCheckedModeBanner: false,
      routes: AppRoutes().appRoutes,
      initialRoute: AppRoutes.loginPage,
    );
  }
}
