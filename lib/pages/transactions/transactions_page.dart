import 'package:flutter/material.dart';
import 'package:mis_gastos/provider/transaction_provider.dart';
import 'package:provider/provider.dart';

final List<int> numeros = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * .025),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: size.width * .5,
                height: size.height * .05,
                color: Colors.deepPurple,
                child: Center(
                  child: Text(
                    'Saldo',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Consumer<TransactionProvider>(
                    builder: (context, value, child) => Text(
                      '\$${value.balance.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Consumer<TransactionProvider>(
              builder: (context, transactionProv, child) {
                final transactions = transactionProv.transactions;
                if (transactions == null) {
                  return const Center(
                    child: Text('Error al cargar Transacciones'),
                  );
                }
                if (transactions.isEmpty) {
                  return const Center(
                    child: Text('No existen transacciones registradas'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      return ListTile(
                        leading: transaction.amount > 0
                            ? Icon(
                                Icons.attach_money_sharp,
                                color: Colors.deepPurple,
                              )
                            : Icon(
                                Icons.money_off_sharp,
                                color: Colors.purpleAccent,
                              ),
                        title: transaction.description != null
                            ? Text(
                                transaction.description!,
                                style: TextStyle(fontSize: 12),
                              )
                            : Text(''),
                        trailing: transaction.amount > 0
                            ? Text(
                                '${transaction.amount}',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple),
                              )
                            : Text(
                                '${transaction.amount}',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purpleAccent),
                              ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
