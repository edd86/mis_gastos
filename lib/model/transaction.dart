class Transaction {
  int? id;
  DateTime date;
  double amount;
  String type;
  String? category;
  String? description;
  int? userId;

  // Constructor para crear una nueva transacción
  Transaction({
    this.id,
    required this.date,
    required this.amount,
    required this.type,
    this.category,
    this.description,
    this.userId,
  });

  // Constructor para crear una transacción a partir de un mapa (por ejemplo, al recuperar de la base de datos)
  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      date: DateTime.parse(map['date']),
      amount: map['amount'],
      type: map['type'],
      category: map['category'],
      description: map['description'],
      userId: map['user_id'],
    );
  }

  // Método para convertir la transacción a un mapa (para insertar en la base de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),  //2025-01-16T20:30:51.000
      'amount': amount,
      'type': type,
      'category': category,
      'description': description,
      'user_id': userId,
    };
  }

  Transaction copyWith({
    int? id,
    DateTime? date,
    double? amount,
    String? type,
    String? category,
    String? description,
    int? userId,
  }) {
    return Transaction(
      id: id ?? this.id,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      category: category ?? this.category,
      description: description ?? this.description,
      userId: userId ?? this.userId,
    );
  }
}
