// lib/models/bill_model.dart

class Bill {
  int? id;
  String description;
  String type; // 'pagar' ou 'receber'
  double value;
  DateTime dueDate;
  bool isPaid;

  Bill({
    this.id,
    required this.description,
    required this.type,
    required this.value,
    required this.dueDate,
    this.isPaid = false,
  });

  // Converte um Map vindo do DB para um objeto Bill
  factory Bill.fromMap(Map<String, dynamic> map) {
    return Bill(
      id: map['id'],
      description: map['description'],
      type: map['type'],
      value: map['value'],
      dueDate: DateTime.parse(map['dueDate']),
      isPaid: map['isPaid'] == 1,
    );
  }

  // Converte o objeto Bill para um Map para salvar no DB
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'type': type,
      'value': value,
      'dueDate': dueDate.toIso8601String(),
      'isPaid': isPaid ? 1 : 0,
    };
  }
}
