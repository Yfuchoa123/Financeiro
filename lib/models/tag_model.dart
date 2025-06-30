// lib/models/tag_model.dart

import 'package:flutter/material.dart';

class Tag {
  String name;
  Color color;
  bool isActive;

  Tag({
    required this.name,
    required this.color,
    this.isActive = true,
  });

  // Construtor para criar uma Tag a partir de um Map do DB
  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      name: map['name'],
      // Converte o inteiro do DB para um objeto Color
      color: Color(map['color']),
      isActive: map['isActive'] == 1,
    );
  }

  // Método para converter o objeto Tag em um Map para salvar no DB
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      // Salva o valor da cor como um inteiro
      'color': color.value,
      'isActive': isActive ? 1 : 0,
    };
  }
}
