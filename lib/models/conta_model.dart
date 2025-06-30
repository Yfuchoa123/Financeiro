// lib/models/conta_model.dart

class Conta {
  int? id;
  String name;
  String type; // 'corrente' ou 'cartao'
  double initialBalance;
  bool isActive;

  Conta({
    this.id,
    required this.name,
    required this.type,
    this.initialBalance = 0.0,
    this.isActive = true,
  });

  // Converte um Map vindo do DB para um objeto Conta
  factory Conta.fromMap(Map<String, dynamic> map) {
    return Conta(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      initialBalance: map['initialBalance'],
      isActive: map['isActive'] == 1,
    );
  }

  // Converte o objeto Conta para um Map para salvar no DB
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'initialBalance': initialBalance,
      'isActive': isActive ? 1 : 0,
    };
  }
}
