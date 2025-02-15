import 'package:flutter/material.dart';
import 'package:mis_gastos/model/budget.dart';
import 'package:mis_gastos/pages/widgets/global_widgets.dart';
import 'package:mis_gastos/provider/budget_provider.dart';
import 'package:mis_gastos/repository/budget_repository.dart';
import 'package:mis_gastos/variables/utils.dart';
import 'package:provider/provider.dart';

class BudgetUpdatePage extends StatefulWidget {
  final Budget budget;
  const BudgetUpdatePage({required this.budget, super.key});

  @override
  State<BudgetUpdatePage> createState() => _BudgetUpdatePageState();
}

class _BudgetUpdatePageState extends State<BudgetUpdatePage> {
  final _amountController = TextEditingController();
  final _expenseBudgetController = TextEditingController();
  late DateTime _initDate;
  late DateTime _endDate;
  late int _userId;

  @override
  void initState() {
    _amountController.text = widget.budget.amount.toString();
    _expenseBudgetController.text = widget.budget.expenseBudget.toString();
    _initDate = widget.budget.initDate;
    _endDate = widget.budget.endDate;
    _userId = widget.budget.userId!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Actualizar Presupuesto'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  label: Text('Monto a actualizar'),
                  labelStyle: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: _expenseBudgetController,
                decoration: InputDecoration(
                  label: Text('Gasto a actualizar'),
                  labelStyle: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child:
                        Text('Inicio: ${Utils().convertFromDate(_initDate)}'),
                    onPressed: () => _selectDate(true),
                  ),
                  TextButton(
                    child: Text('Final: ${Utils().convertFromDate(_endDate)}'),
                    onPressed: () => _selectDate(false),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton.icon(
                label: Text('Actualizar Datos'),
                icon: Icon(
                  Icons.update,
                  color: Colors.white,
                ),
                style: GlobalWidgets().buttonStyle,
                onPressed: () async {
                  final budgetRepo = BudgetRepository();
                  final cont = await budgetRepo.updateBudget(
                    Budget(
                        id: widget.budget.id,
                        initDate: _initDate,
                        endDate: _endDate,
                        amount: double.parse(_amountController.text),
                        expenseBudget:
                            double.parse(_expenseBudgetController.text),
                        userId: _userId),
                  );
                  if (cont != null && cont > 0) {
                    _budgetUpdated();
                  } else {
                    _budgetNotUpdated();
                  }
                },
              )
            ],
          ),
        ));
  }

  void _selectDate(bool bool) async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: bool ? _initDate : _endDate,
    );
    if (pickedDate != null) {
      setState(() {
        bool ? _initDate = pickedDate : _endDate = pickedDate;
      });
    }
  }

  void _budgetUpdated() {
    GlobalWidgets()
        .showSanckBar(context, 'Presupuesto actualizado exitosamente');
    final notifier = Provider.of<BudgetProvider>(context, listen: false);
    notifier.updateBudgets();
    Navigator.pop(context);
  }

  void _budgetNotUpdated() {
    GlobalWidgets().showSanckBar(context, 'Error al actualizar el presupuesto');
  }
}
