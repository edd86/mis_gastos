import 'package:flutter/material.dart';
import 'package:mis_gastos/model/expense.dart';
import 'package:mis_gastos/model/transaction.dart';
import 'package:mis_gastos/pages/widgets/global_widgets.dart';
import 'package:mis_gastos/provider/transaction_provider.dart';
import 'package:mis_gastos/repository/expense_repository.dart';
import 'package:mis_gastos/repository/transaction_repository.dart';
import 'package:mis_gastos/variables/global_variables.dart';
import 'package:mis_gastos/variables/utils.dart';
import 'package:provider/provider.dart';

class RegisterExpense extends StatefulWidget {
  const RegisterExpense({super.key});

  @override
  State<RegisterExpense> createState() => _RegisterExpenseState();
}

final _keyForm = GlobalKey<FormState>();
final _descriptionController = TextEditingController();
final _amountController = TextEditingController();
DateTime _date = DateTime.now();

class _RegisterExpenseState extends State<RegisterExpense> {
  @override
  void dispose() {
    _descriptionController.clear();
    _amountController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _keyForm,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 50,
        ),
        child: Column(
          children: [
            TextFormField(
              controller: _descriptionController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: Row(
                  children: [
                    Icon(
                      Icons.description,
                      color: Colors.deepPurpleAccent,
                      size: 18,
                    ),
                    const SizedBox(width: 5),
                    const Text('Descripción'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                      color: Colors.deepPurpleAccent,
                      size: 18,
                    ),
                    const SizedBox(width: 5),
                    const Text('Monto'),
                  ],
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese un monto';
                } else if (double.tryParse(value)! < 0) {
                  return 'Ingrese un monto válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            TextButton(
              child: Text(
                Utils().convertFromDate(_date),
              ),
              onPressed: () {
                _selectDate();
              },
            ),
            const SizedBox(height: 35),
            ElevatedButton.icon(
              label: Text('Registrar Gasto'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                if (_keyForm.currentState!.validate()) {
                  String description = _descriptionController.text;
                  double amount = double.parse(_amountController.text);
                  final transactionRepo = TransactionRepository();
                  final expenseRepo = ExpenseRepository();
                  Transaction transaction = Transaction(
                    description: description,
                    amount: amount * -1,
                    type: 'expense',
                    date: _date,
                    userId: userLogged!.id,
                  );
                  final newTransaction =
                      await transactionRepo.addTransaction(transaction);
                  if (newTransaction!.id != null) {
                    Expense expense = Expense(
                      transactionId: newTransaction.id!,
                      amount: amount,
                    );
                    final newExpense = await expenseRepo.addExpense(expense);
                    if (newExpense!.id != null) {
                      _expenseRegistered();
                    } else {
                      _expenseNotRegistered();
                    }
                  } else {
                    _expenseNotRegistered();
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(_date.year - 1),
      lastDate: _date,
    );
    if (pickedDate != null) {
      setState(() {
        _date = pickedDate;
      });
    }
  }

  void _expenseRegistered() {
    final notifier = Provider.of<TransactionProvider>(context, listen: false);
    notifier.updateTransactions();
    GlobalWidgets().showSanckBar(context, 'Gasto registrado exitosamente');
    Navigator.pop(context);
  }

  void _expenseNotRegistered() {
    GlobalWidgets().showSanckBar(context, 'Error al registrar el gasto');
  }
}
