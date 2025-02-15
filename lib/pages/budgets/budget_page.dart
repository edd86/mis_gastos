import 'package:flutter/material.dart';
import 'package:mis_gastos/pages/budgets/budget_card_widget.dart';
import 'package:mis_gastos/pages/budgets/budget_update_page.dart';
import 'package:mis_gastos/pages/widgets/amount_dialog_widget.dart';
import 'package:mis_gastos/provider/budget_provider.dart';
import 'package:provider/provider.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BudgetProvider>(
      builder: (context, budgetProvider, child) {
        final budgets = budgetProvider.budgets;
        if (budgets!.isEmpty) {
          return const Center(
            child: Text('No existen presupuestos'),
          );
        }
        return ListView.builder(
          itemCount: budgets.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: BudgetCardWidget(
                budget: budgets[index],
              ),
              onTap: () => showDialog(
                context: context,
                builder: (context) =>
                    AmountDialogWidget(budget: budgets[index]),
              ),
              onLongPress: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          BudgetUpdatePage(budget: budgets[index]))),
            );
          },
        );
      },
    );
  }
}
