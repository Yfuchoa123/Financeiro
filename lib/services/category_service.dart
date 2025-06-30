// lib/services/category_service.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_financeiro_pessoal/database/database_helper.dart';
import 'package:meu_financeiro_pessoal/models/category_model.dart';
import 'package:sqflite/sqflite.dart';

class CategoryState {
  final List<Category> despesas;
  final List<Category> receitas;
  CategoryState({required this.despesas, required this.receitas});

  CategoryState copyWith({List<Category>? despesas, List<Category>? receitas}) {
    return CategoryState(
      despesas: despesas ?? this.despesas,
      receitas: receitas ?? this.receitas,
    );
  }
}

class CategoryNotifier extends StateNotifier<AsyncValue<CategoryState>> {
  CategoryNotifier() : super(const AsyncValue.loading()) {
    loadCategories();
  }

  Future<void> loadCategories() async {
    state = const AsyncValue.loading();
    try {
      final db = await DatabaseHelper().database;

      final List<Map<String, dynamic>> despesasMaps = await db
          .query('categories', where: 'type = ?', whereArgs: ['despesa']);
      final List<Map<String, dynamic>> receitasMaps = await db
          .query('categories', where: 'type = ?', whereArgs: ['receita']);

      final despesas = List.generate(
          despesasMaps.length, (i) => Category.fromMap(despesasMaps[i]));
      final receitas = List.generate(
          receitasMaps.length, (i) => Category.fromMap(receitasMaps[i]));

      if (despesas.isEmpty && receitas.isEmpty) {
        await _insertInitialData();
        await loadCategories();
        return;
      }

      state = AsyncValue.data(
          CategoryState(despesas: despesas, receitas: receitas));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> addCategoria(String name, String type,
      {String? parentName}) async {
    final db = await DatabaseHelper().database;
    final category = Category(name: name, parentName: parentName);
    await db.insert(
      'categories',
      category.toMap(type: type),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await loadCategories();
  }

  Future<void> updateCategoria(String oldName, String newName) async {
    final db = await DatabaseHelper().database;
    await db.update(
      'categories',
      {'name': newName},
      where: 'name = ?',
      whereArgs: [oldName],
    );
    await loadCategories();
  }

  Future<void> deleteCategoria(String name) async {
    final db = await DatabaseHelper().database;
    await db.delete(
      'categories',
      where: 'name = ?',
      whereArgs: [name],
    );
    await loadCategories();
  }

  Future<void> toggleStatus(Category category) async {
    final db = await DatabaseHelper().database;
    category.isActive = !category.isActive;
    await db.update(
      'categories',
      {'isActive': category.isActive ? 1 : 0},
      where: 'name = ?',
      whereArgs: [category.name],
    );
    await loadCategories();
  }

  Future<void> _insertInitialData() async {
    await addCategoria('Automóvel', 'despesa');
    await addCategoria('Combustível', 'despesa', parentName: 'Automóvel');
    await addCategoria('Salário', 'receita');
  }
}

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, AsyncValue<CategoryState>>((ref) {
  return CategoryNotifier();
});
