import 'package:flutter/material.dart';
import 'package:mis_gastos/model/debt.dart';
import 'package:mis_gastos/pages/widgets/global_widgets.dart';
import 'package:mis_gastos/provider/debt_provider.dart';
import 'package:mis_gastos/repository/debt_repository.dart';
import 'package:mis_gastos/variables/global_variables.dart';
import 'package:mis_gastos/variables/utils.dart';
import 'package:provider/provider.dart';

class RegisterDebt extends StatefulWidget {
  const RegisterDebt({super.key});

  @override
  State<RegisterDebt> createState() => _RegisterDebtState();
}

class _RegisterDebtState extends State<RegisterDebt> {
  final _formKey = GlobalKey<FormState>();
  final _creditorController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: size.height * .05,
          horizontal: size.width * .15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              controller: _creditorController,
              decoration: InputDecoration(
                labelText: 'Nombre del prestamista',
                labelStyle: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Debe ingresar un nombre';
                }
                return null;
              },
            ),
            SizedBox(
              height: size.height * .025,
            ),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Descripción del crédito',
                labelStyle: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: size.height * .025,
            ),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Monto del crédito',
                labelStyle: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Debe ingresar un monto';
                }
                return null;
              },
            ),
            SizedBox(
              height: size.height * .025,
            ),
            TextButton(
              child: Text(Utils().convertFromDate(_date!)),
              onPressed: () => _selectDate(),
            ),
            SizedBox(
              height: size.height * .025,
            ),
            ElevatedButton.icon(
              label: Text('Registrar Crédito'),
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ),
              style: GlobalWidgets().buttonStyle,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final debt = Debt(
                    creditor: _creditorController.text,
                    amount: double.parse(_amountController.text),
                    date: _date!,
                    description: _descriptionController.text,
                    userId: userLogged!.id,
                  );
                  final newDebt = await DebtRepository().addDebt(debt);
                  if (newDebt != null && newDebt.id != null) {
                    _debtRegistered();
                  } else {
                    newDebt!.id != null ? _debtNotRegistered() : _debtNull();
                  }
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
        firstDate: DateTime(DateTime.now().year - 10),
        lastDate: DateTime.now(),
        initialDate: _date);
    if (pickedDate != null) {
      setState(() {
        _date = pickedDate;
      });
    }
  }

  void _debtRegistered() {
    GlobalWidgets().showSanckBar(context, 'Crédito registrado exitosamente');
    final notifier = Provider.of<DebtProvider>(context, listen: false);
    notifier.getDebts();
    Navigator.pop(context);
  }

  _debtNotRegistered() {
    GlobalWidgets().showSanckBar(context, 'Crédito no registrado');
  }

  _debtNull() {
    GlobalWidgets().showSanckBar(context, 'Error de conexión a la BD');
  }
}
