import 'package:flutter/material.dart';
import 'package:mis_gastos/pages/budgets/budget_page.dart';
import 'package:mis_gastos/pages/debt/debt_page.dart';
import 'package:mis_gastos/pages/transactions/transactions_page.dart';
import 'package:mis_gastos/routes/app_routes.dart';
import 'package:mis_gastos/variables/destinations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        indicatorColor: Colors.deepPurple[200],
        destinations: Destinations.destinations
            .map((elemento) => NavigationDestination(
                  icon: Icon(elemento.icon),
                  label: elemento.label,
                  selectedIcon: Icon(elemento.iconSelected),
                ))
            .toList(),
        onDestinationSelected: (value) => setState(() {
          _currentIndex = value;
        }),
      ),
      body: <Widget>[
        TransactionsPage(),
        Center(
          child: Text('Ingresos'),
        ),
        BudgetPage(),
        DebtPage()
      ][_currentIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
        onPressed: () => Navigator.pushNamed(context, AppRoutes.operations),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
