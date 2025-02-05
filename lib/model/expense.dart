class Expense {
  int? id;
  int transactionId;
  double amount;
  int? budgetId;

  // Constructor para crear un nuevo gasto
  Expense({
    this.id,
    required this.transactionId,
    required this.amount,
    this.budgetId,
  });

  // Constructor para crear un gasto a partir de un mapa (por ejemplo, al recuperar de la base de datos)
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      transactionId: map['transaction_id'],
      amount: map['amount'],
      budgetId: map['budget_id'],
    );
  }

  // Método para convertir el gasto a un mapa (para insertar en la base de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transaction_id': transactionId,
      'amount': amount,
      'budget_id': budgetId,
    };
  }

  Expense copyWith({
    int? id,
    int? transactionId,
    double? amount,
    int? budgetId,
  }) {
    return Expense(
      id: id ?? this.id,
      transactionId: transactionId ?? this.transactionId,
      amount: amount ?? this.amount,
      budgetId: budgetId ?? this.budgetId,
    );
  }
}
