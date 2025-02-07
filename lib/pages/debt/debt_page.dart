import 'package:flutter/material.dart';
import 'package:mis_gastos/pages/debt/debt_card_widget.dart';
import 'package:mis_gastos/provider/debt_provider.dart';
import 'package:provider/provider.dart';

class DebtPage extends StatefulWidget {
  const DebtPage({super.key});

  @override
  State<DebtPage> createState() => _DebtPageState();
}

class _DebtPageState extends State<DebtPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DebtProvider>(builder: (context, debtProvider, child) {
      final debts = debtProvider.debts;
      if (debts.isEmpty) {
        return Center(
          child: Text('No hay deudas'),
        );
      }
      return ListView.builder(
        itemCount: debts.length,
        itemBuilder: (context, index) {
          return DebtCardWidget(debt: debts[index]);
        },
      );
    });
  }
}
