// lib/models/lancamento_model.dart

class Lancamento {
  final int? id;
  final String description;
  final String type; // 'despesa', 'receita', 'transferencia'
  final double value;
  final DateTime date;
  final int accountId;
  final String categoryName;
  final bool isPaid;

  Lancamento({
    this.id,
    required this.description,
    required this.type,
    required this.value,
    required this.date,
    required this.accountId,
    required this.categoryName,
    this.isPaid = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'type': type,
      'value': value,
      'date': date.toIso8601String(),
      'accountId': accountId,
      'categoryName': categoryName,
      'isPaid': isPaid ? 1 : 0,
    };
  }

  factory Lancamento.fromMap(Map<String, dynamic> map) {
    return Lancamento(
      id: map['id'],
      description: map['description'],
      type: map['type'],
      value: map['value'],
      date: DateTime.parse(map['date']),
      accountId: map['accountId'],
      categoryName: map['categoryName'],
      isPaid: map['isPaid'] == 1,
    );
  }
}
