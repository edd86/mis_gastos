class Budget {
  int? id;
  DateTime initDate;
  DateTime endDate;
  double amount;
  double expenseBudget;
  int? userId;

  // Constructor para crear un nuevo presupuesto
  Budget({
    this.id,
    required this.initDate,
    required this.endDate,
    required this.amount,
    required this.expenseBudget,
    this.userId,
  });

  // Constructor para crear un presupuesto a partir de un mapa (por ejemplo, al recuperar de la base de datos)
  factory Budget.fromMap(Map<String, dynamic> map) {
    return Budget(
      id: map['id'],
      initDate: DateTime.parse(map['init_date']),
      endDate: DateTime.parse(map['end_date']),
      amount: map['income_budget'],
      expenseBudget: map['expense_budget'],
      userId: map['user_id'],
    );
  }

  // Método para convertir el presupuesto a un mapa (para insertar en la base de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'init_date': initDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'income_budget': amount,
      'expense_budget': expenseBudget,
      'user_id': userId,
    };
  }

  Budget copyWith({
    int? id,
    DateTime? initDate,
    DateTime? endDate,
    double? amount,
    double? expenseBudget,
    int? userId,
  }) {
    return Budget(
      id: id ?? this.id,
      initDate: initDate ?? this.initDate,
      endDate: endDate ?? this.endDate,
      amount: amount ?? this.amount,
      expenseBudget: expenseBudget ?? this.expenseBudget,
      userId: userId ?? this.userId,
    );
  }
}
