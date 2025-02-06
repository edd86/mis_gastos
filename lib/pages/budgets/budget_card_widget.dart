import 'package:flutter/material.dart';
import 'package:mis_gastos/model/budget.dart';
import 'package:mis_gastos/pages/widgets/global_widgets.dart';
import 'package:mis_gastos/variables/utils.dart';

class BudgetCardWidget extends StatelessWidget {
  final Budget budget;
  const BudgetCardWidget({required this.budget, super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      color: Colors.deepPurple,
      child: SizedBox(
        height: size.height * .12,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Inicio: ${Utils().convertFromDate(budget.initDate)}',
                    style: GlobalWidgets().textStyleCard,
                  ),
                  Text(
                    'Fin: ${Utils().convertFromDate(budget.endDate)}',
                    style: GlobalWidgets().textStyleCard,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Monto: ${budget.amount}',
                    style: GlobalWidgets().textStyleCard,
                  ),
                  Text(
                    'Presupuesto: ${budget.expenseBudget}',
                    style: GlobalWidgets().textStyleCard,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
