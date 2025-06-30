// lib/models/category_model.dart

class Category {
  String name;
  bool isActive;
  String? parentName;

  Category({
    required this.name,
    this.isActive = true,
    this.parentName,
  });

  // Construtor factory para criar uma Category a partir de um Map vindo do DB
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name'],
      // SQLite guarda booleano como 0 ou 1
      isActive: map['isActive'] == 1,
      parentName: map['parentName'],
    );
  }

  // Método para converter um objeto Category em um Map para salvar no DB
  Map<String, dynamic> toMap({required String type}) {
    return {
      'name': name,
      'type': type,
      'isActive': isActive ? 1 : 0,
      'parentName': parentName,
    };
  }
}
