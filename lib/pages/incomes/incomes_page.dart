import 'package:flutter/material.dart';
import 'package:mis_gastos/provider/incomes_provider.dart';
import 'package:provider/provider.dart';

class IncomesPage extends StatelessWidget {
  const IncomesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<IncomesProvider>(
        builder: (context, incomesProvider, child) {
      final incomes = incomesProvider.incomes;
      if (incomes == null) {
        return const Center(
          child: Text('Error al cargar ingresos'),
        );
      }
      if (incomes.isEmpty) {
        return const Center(
          child: Text('No existen ingresos registrados'),
        );
      }
      return ListView.builder(
        itemCount: incomes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              incomes[index].amount.toString(),
            ),
            subtitle: Text(incomes[index].transactionId.toString()),
          );
        },
      );
    });
  }
}
