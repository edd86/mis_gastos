import 'package:flutter/material.dart';
import 'package:mis_gastos/model/budget.dart';
import 'package:mis_gastos/pages/widgets/global_widgets.dart';
import 'package:mis_gastos/provider/budget_provider.dart';
import 'package:mis_gastos/repository/budget_repository.dart';
import 'package:mis_gastos/variables/global_variables.dart';
import 'package:mis_gastos/variables/utils.dart';
import 'package:provider/provider.dart';

class RegisterBudget extends StatefulWidget {
  const RegisterBudget({super.key});

  @override
  State<RegisterBudget> createState() => _RegisterBudgetState();
}

class _RegisterBudgetState extends State<RegisterBudget> {
  final _amountController = TextEditingController();
  DateTime _initialDate = DateTime.now();
  DateTime _finalDate = DateTime.now();

  @override
  void dispose() {
    _amountController.clear();
    _initialDate = DateTime.now();
    _finalDate = DateTime.now();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * .15,
          vertical: size.height * .1,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
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
                    const Text('Monto del presupuesto'),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * .05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: Text(
                    Utils().convertFromDate(_initialDate),
                  ),
                  onPressed: () => _selectDate(true),
                ),
                TextButton(
                  child: Text(
                    Utils().convertFromDate(_finalDate),
                  ),
                  onPressed: () => _selectDate(false),
                ),
              ],
            ),
            SizedBox(height: size.height * .05),
            ElevatedButton.icon(
              label: Text('Registrar Presupuesto'),
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                final budget = await BudgetRepository().addBudget(Budget(
                  initDate: _initialDate,
                  endDate: _finalDate,
                  amount: double.parse(_amountController.text),
                  expenseBudget: 0.0,
                  userId: userLogged!.id,
                ));
                if (budget == null) {
                  _budgetNull();
                } else {
                  budget.id != null
                      ? _budgetRegistered()
                      : _budgetNotRegistered();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _selectDate(bool flag) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year).add(Duration(days: 400)),
      initialDate: DateTime.now(),
    );
    if (pickedDate != null) {
      flag
          ? setState(() {
              _initialDate = pickedDate;
            })
          : setState(() {
              _finalDate = pickedDate;
            });
    }
  }

  _budgetRegistered() {
    GlobalWidgets()
        .showSanckBar(context, 'Presupuesto registrado exitosamente');
    final notifier = Provider.of<BudgetProvider>(context, listen: false);
    notifier.updateBudgets();
    Navigator.pop(context);
  }

  _budgetNotRegistered() {
    GlobalWidgets().showSanckBar(context, 'Presupuesto no registrado');
  }

  void _budgetNull() {
    GlobalWidgets().showSanckBar(context, 'Error al registrar el presupuesto');
  }
}
