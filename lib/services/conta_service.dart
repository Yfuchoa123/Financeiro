// lib/services/conta_service.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_financeiro_pessoal/database/database_helper.dart';
import 'package:meu_financeiro_pessoal/models/conta_model.dart';
import 'package:sqflite/sqflite.dart';

// O Notifier que vai gerenciar o estado da nossa lista de contas
class ContaNotifier extends StateNotifier<AsyncValue<List<Conta>>> {
  ContaNotifier() : super(const AsyncValue.loading()) {
    loadContas();
  }

  // Carrega as contas do banco de dados
  Future<void> loadContas() async {
    state = const AsyncValue.loading();
    try {
      final db = await DatabaseHelper().database;
      final List<Map<String, dynamic>> maps = await db.query('accounts');
      final contas = List.generate(maps.length, (i) => Conta.fromMap(maps[i]));

      // Se o banco estiver vazio, insere os dados iniciais
      if (contas.isEmpty) {
        await _insertInitialData();
        await loadContas(); // Recarrega após inserir os dados iniciais
        return;
      }

      state = AsyncValue.data(contas);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  // Insere dados de exemplo na primeira execução do app
  Future<void> _insertInitialData() async {
    await addConta('Conta corrente', 'corrente', initialBalance: 2131.32);
    await addConta('Yuri Yuri', 'cartao');
  }

  // --- MÉTODOS PARA MODIFICAR O ESTADO (CRUD) ---

  Future<void> addConta(String name, String type,
      {double initialBalance = 0.0}) async {
    final db = await DatabaseHelper().database;
    final conta = Conta(name: name, type: type, initialBalance: initialBalance);
    // Usa o método toMap do nosso modelo para inserir no DB
    await db.insert('accounts', conta.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    await loadContas(); // Recarrega a lista para atualizar a UI
  }

  Future<void> updateConta(Conta conta) async {
    final db = await DatabaseHelper().database;
    await db.update('accounts', conta.toMap(),
        where: 'id = ?', whereArgs: [conta.id]);
    await loadContas();
  }

  Future<void> deleteConta(int id) async {
    final db = await DatabaseHelper().database;
    await db.delete('accounts', where: 'id = ?', whereArgs: [id]);
    await loadContas();
  }

  Future<void> toggleStatus(Conta conta) async {
    conta.isActive = !conta.isActive;
    await updateConta(conta);
  }
}

// O Provider que a nossa UI vai usar para acessar o Notifier
final contaProvider =
    StateNotifierProvider<ContaNotifier, AsyncValue<List<Conta>>>((ref) {
  return ContaNotifier();
});
