import 'package:flutter/material.dart';
import 'package:mis_gastos/model/budget.dart';
import 'package:mis_gastos/model/debt.dart';
import 'package:mis_gastos/model/expense.dart';
import 'package:mis_gastos/model/transaction.dart';
import 'package:mis_gastos/pages/widgets/global_widgets.dart';
import 'package:mis_gastos/provider/budget_provider.dart';
import 'package:mis_gastos/provider/transaction_provider.dart';
import 'package:mis_gastos/repository/budget_repository.dart';
import 'package:mis_gastos/repository/expense_repository.dart';
import 'package:mis_gastos/repository/transaction_repository.dart';
import 'package:mis_gastos/variables/global_variables.dart';
import 'package:mis_gastos/variables/utils.dart';
import 'package:provider/provider.dart';

class AmountDialogWidget extends StatelessWidget {
  final Budget? budget;
  final Debt? debt;
  final _amountController = TextEditingController();
  AmountDialogWidget({this.budget, this.debt, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Inserte un monto',
        textAlign: TextAlign.center,
      ),
      content: TextField(
        controller: _amountController,
        keyboardType: TextInputType.number,
      ),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text('Aceptar'),
          onPressed: () async {
            if (budget != null) {
              if (_amountController.text.isNotEmpty) {
                double amount = double.parse(_amountController.text);
                int? cont = await BudgetRepository()
                    .updateExpenseBudget(amount, budget!.id!);
                if (cont != null) {
                  GlobalWidgets().showSanckBar(context, 'Monto actualizado');
                  final newTransaction =
                      await TransactionRepository().addTransaction(Transaction(
                    date: DateTime.now(),
                    amount: amount * -1,
                    type: 'expense',
                    description:
                        'Presupuesto ${Utils().convertFromDate(budget!.initDate)} - ${Utils().convertFromDate(budget!.endDate)}',
                    userId: userLogged!.id,
                  ));
                  if (newTransaction != null && newTransaction.id != null) {
                    final newExpense =
                        await ExpenseRepository().addExpense(Expense(
                      transactionId: newTransaction.id!,
                      amount: amount,
                      budgetId: budget!.id,
                    ));
                    if (newExpense != null && newExpense.id != null) {
                      final budgetNotifier =
                          Provider.of<BudgetProvider>(context, listen: false);
                      final transactionNotifier =
                          Provider.of<TransactionProvider>(context,
                              listen: false);
                      transactionNotifier.updateTransactions();
                      budgetNotifier.updateBudgets();
                      Navigator.pop(context);
                    }
                  }
                } else {
                  GlobalWidgets().showSanckBar(context, 'Error al actualizar');
                }
              } else {
                GlobalWidgets().showSanckBar(context, 'Debe ingresar un monto');
              }
            }
            if (debt != null) {}
          },
        )
      ],
    );
  }
}
