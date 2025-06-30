// lib/services/tag_service.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_financeiro_pessoal/database/database_helper.dart';
import 'package:meu_financeiro_pessoal/models/tag_model.dart';
import 'package:sqflite/sqflite.dart';

class TagNotifier extends StateNotifier<AsyncValue<List<Tag>>> {
  TagNotifier() : super(const AsyncValue.loading()) {
    loadTags();
  }

  Future<void> loadTags() async {
    state = const AsyncValue.loading();
    try {
      final db = await DatabaseHelper().database;
      final List<Map<String, dynamic>> maps = await db.query('tags');

      final tags = List.generate(maps.length, (i) => Tag.fromMap(maps[i]));

      if (tags.isEmpty) {
        await _insertInitialData();
        await loadTags(); // Recarrega após inserir
        return;
      }

      state = AsyncValue.data(tags);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> _insertInitialData() async {
    await addTag('Internet', Colors.purple[400]!);
    await addTag('Trabalho', Colors.orange[600]!);
  }

  // --- MÉTODOS DE MODIFICAÇÃO COM SQL ---

  Future<void> addTag(String name, Color color) async {
    final db = await DatabaseHelper().database;
    final tag = Tag(name: name, color: color);
    await db.insert('tags', tag.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    await loadTags();
  }

  Future<void> updateTag(String oldName, String newName, Color newColor) async {
    final db = await DatabaseHelper().database;
    await db.update(
      'tags',
      {'name': newName, 'color': newColor.value},
      where: 'name = ?',
      whereArgs: [oldName],
    );
    await loadTags();
  }

  Future<void> deleteTag(String name) async {
    final db = await DatabaseHelper().database;
    await db.delete('tags', where: 'name = ?', whereArgs: [name]);
    await loadTags();
  }

  Future<void> toggleStatus(Tag tag) async {
    final db = await DatabaseHelper().database;
    tag.isActive = !tag.isActive;
    await db
        .update('tags', tag.toMap(), where: 'name = ?', whereArgs: [tag.name]);
    await loadTags();
  }
}

final tagProvider =
    StateNotifierProvider<TagNotifier, AsyncValue<List<Tag>>>((ref) {
  return TagNotifier();
});
