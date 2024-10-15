// lib/models/transaction.dart
class Transaction {
  final int? id;  // O ID pode ser opcional
  final String description;
  final double amount;

  Transaction({
    this.id, // O ID é opcional
    required this.description,
    required this.amount,
  });

  // Método para converter JSON em objeto Transaction
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      description: json['description'],
      amount: json['amount'].toDouble(),
    );
  }

  // Método para converter Transaction para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'amount': amount,
    };
  }
}
