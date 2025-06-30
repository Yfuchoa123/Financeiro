// lib/services/lancamento_service.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_financeiro_pessoal/database/database_helper.dart';
import 'package:meu_financeiro_pessoal/models/lancamento_model.dart';

class LancamentoNotifier extends StateNotifier<AsyncValue<List<Lancamento>>> {
  LancamentoNotifier() : super(const AsyncValue.loading()) {
    loadLancamentos();
  }

  Future<void> loadLancamentos() async {
    state = const AsyncValue.loading();
    try {
      final db = await DatabaseHelper().database;
      final List<Map<String, dynamic>> maps =
          await db.query('transactions', orderBy: 'date DESC');
      final lancamentos =
          List.generate(maps.length, (i) => Lancamento.fromMap(maps[i]));
      state = AsyncValue.data(lancamentos);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> addLancamento(Lancamento lancamento) async {
    final db = await DatabaseHelper().database;
    await db.insert('transactions', lancamento.toMap());
    await loadLancamentos();
  }

  // Adicione aqui os métodos update e delete no futuro
}

final lancamentoProvider =
    StateNotifierProvider<LancamentoNotifier, AsyncValue<List<Lancamento>>>(
        (ref) {
  return LancamentoNotifier();
});
