import 'package:flutter/material.dart';
import 'package:mis_gastos/pages/budgets/budget_card_widget.dart';
import 'package:mis_gastos/pages/widgets/global_widgets.dart';
import 'package:mis_gastos/provider/budget_provider.dart';
import 'package:provider/provider.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BudgetProvider>(
      builder: (context, budgetRepo, child) {
        final budgets = budgetRepo.budgets;
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
              //TODO: Agregar función para modificar el presupuesto
              onTap: () => GlobalWidgets()
                  .showSanckBar(context, budgets[index].amount.toString()),
            );
          },
        );
      },
    );
  }
}
