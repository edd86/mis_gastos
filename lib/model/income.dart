class Income {
  int? id;
  int transactionId;
  double amount;

  // Constructor para crear un nuevo ingreso
  Income({
    this.id,
    required this.transactionId,
    required this.amount,
  });

  // Constructor para crear un ingreso a partir de un mapa (por ejemplo, al recuperar de la base de datos)
  factory Income.fromMap(Map<String, dynamic> map) {
    return Income(
      id: map['id'],
      transactionId: map['transaction_id'],
      amount: map['amount'],
    );
  }

  // Método para convertir el ingreso a un mapa (para insertar en la base de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transaction_id': transactionId,
      'amount': amount,
    };
  }

  Income copyWith({
    int? id,
    int? transactionId,
    double? amount,
  }) {
    return Income(
      id: id ?? this.id,
      transactionId: transactionId ?? this.transactionId,
      amount: amount ?? this.amount,
    );
  }
}
