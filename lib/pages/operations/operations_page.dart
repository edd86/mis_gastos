import 'package:flutter/material.dart';
import 'package:mis_gastos/pages/budgets/register_budget.dart';
import 'package:mis_gastos/pages/debt/register_debt.dart';
import 'package:mis_gastos/pages/expenses/register_expense.dart';
import 'package:mis_gastos/pages/incomes/register_income.dart';

class OperationsPage extends StatelessWidget {
  const OperationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Operaciones'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Ingresos'),
              Tab(text: 'Gastos'),
              Tab(text: 'Presupuestos'),
              Tab(text: 'Préstamos'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RegisterIncome(),
            RegisterExpense(),
            RegisterBudget(),
            RegisterDebt(),
          ],
        ),
      ),
    );
  }
}
