import 'package:flutter/material.dart';
import 'package:mis_gastos/model/income.dart';
import 'package:mis_gastos/model/transaction.dart';
import 'package:mis_gastos/pages/widgets/global_widgets.dart';
import 'package:mis_gastos/provider/transaction_provider.dart';
import 'package:mis_gastos/repository/income_repository.dart';
import 'package:mis_gastos/repository/transaction_repository.dart';
import 'package:mis_gastos/variables/global_variables.dart';
import 'package:mis_gastos/variables/utils.dart';
import 'package:provider/provider.dart';

class RegisterIncome extends StatefulWidget {
  const RegisterIncome({super.key});

  @override
  State<RegisterIncome> createState() => _RegisterIncomeState();
}

final _formKey = GlobalKey<FormState>();
final _descriptionController = TextEditingController();
final _amountController = TextEditingController();
DateTime _date = DateTime.now();

class _RegisterIncomeState extends State<RegisterIncome> {
  @override
  void dispose() {
    _descriptionController.clear();
    _amountController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * .15,
        vertical: size.height * .05,
      ),
      child: Form(
        key: _formKey,
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
              label: Text('Registrar Ingreso'),
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String description = _descriptionController.text;
                  double amount = double.parse(_amountController.text);
                  final transactionRepo = TransactionRepository();
                  final icomeRepo = IncomeRepository();
                  Transaction transaction = Transaction(
                    date: _date,
                    amount: amount,
                    type: 'income',
                    description: description,
                    userId: userLogged!.id,
                  );
                  final newTransaction =
                      await transactionRepo.addTransaction(transaction);
                  if (newTransaction!.id != null) {
                    Income income = Income(
                      transactionId: newTransaction.id!,
                      amount: amount,
                    );
                    final newIncome = await icomeRepo.addIncome(income);
                    if (newIncome!.id != null) {
                      _incomeRegistered();
                    } else {
                      _incomeNotRegistered();
                    }
                  } else {
                    _incomeNotRegistered();
                  }
                } else {
                  GlobalWidgets().showSanckBar(context, 'Datos no válidos');
                }
              },
            ),
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

  void _incomeRegistered() {
    final notifier = Provider.of<TransactionProvider>(context, listen: false);
    notifier.updateTransactions();
    GlobalWidgets().showSanckBar(context, 'Ingreso registrado exitosamente');
    Navigator.pop(context);
  }

  void _incomeNotRegistered() {
    GlobalWidgets().showSanckBar(context, 'Error al registrar el ingreso');
  }
}
