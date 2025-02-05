class Debt {
  int? id;
  String creditor;
  double amount;
  DateTime date;
  String? description;
  int? userId;

  // Constructor para crear una nueva deuda
  Debt({
    this.id,
    required this.creditor,
    required this.amount,
    required this.date,
    this.description,
    this.userId,
  });

  // Constructor para crear una deuda a partir de un mapa (por ejemplo, al recuperar de la base de datos)
  factory Debt.fromMap(Map<String, dynamic> map) {
    return Debt(
      id: map['id'],
      creditor: map['creditor'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      description: map['description'],
      userId: map['user_id'],
    );
  }

  // Método para convertir la deuda a un mapa (para insertar en la base de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'creditor': creditor,
      'amount': amount,
      'date': date.toIso8601String(),
      'description': description,
      'user_id': userId,
    };
  }
}
