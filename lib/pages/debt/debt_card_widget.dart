import 'package:flutter/material.dart';
import 'package:mis_gastos/model/debt.dart';
import 'package:mis_gastos/pages/widgets/global_widgets.dart';
import 'package:mis_gastos/variables/utils.dart';

class DebtCardWidget extends StatelessWidget {
  final Debt debt;
  const DebtCardWidget({required this.debt, super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.2,
      child: Card(
        color: Colors.deepPurple,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Crédito: ${debt.creditor}',
              style: GlobalWidgets().textStyleCard,
            ),
            Text(
              'Monto: ${debt.amount}',
              style: GlobalWidgets().textStyleCard,
            ),
            Text(
              'Fecha: ${Utils().convertFromDate(debt.date)}',
              style: GlobalWidgets().textStyleCard,
            ),
            Text(
              debt.description ?? '',
              style: GlobalWidgets().textStyleCard,
            ),
          ],
        ),
      ),
    );
  }
}
