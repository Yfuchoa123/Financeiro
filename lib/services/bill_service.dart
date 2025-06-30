// lib/services/bill_service.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_financeiro_pessoal/database/database_helper.dart';
import 'package:meu_financeiro_pessoal/models/bill_model.dart';
import 'package:sqflite/sqflite.dart';

// O Notifier que vai gerenciar o estado da nossa lista de contas a pagar/receber
class BillNotifier extends StateNotifier<AsyncValue<List<Bill>>> {
  BillNotifier() : super(const AsyncValue.loading()) {
    loadBills();
  }

  // Carrega as contas do banco de dados
  Future<void> loadBills() async {
    state = const AsyncValue.loading();
    try {
      final db = await DatabaseHelper().database;
      final List<Map<String, dynamic>> maps =
          await db.query('bills', orderBy: 'dueDate ASC');
      final bills = List.generate(maps.length, (i) => Bill.fromMap(maps[i]));

      // Se o banco estiver vazio, insere os dados iniciais
      if (bills.isEmpty) {
        await _insertInitialData();
        await loadBills(); // Recarrega após inserir os dados iniciais
        return;
      }

      state = AsyncValue.data(bills);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  // Insere dados de exemplo na primeira execução do app
  Future<void> _insertInitialData() async {
    await addBill(
      description: 'Aluguel Escritório',
      type: 'pagar',
      value: 1250.00,
      dueDate: DateTime.now().add(const Duration(days: 5)),
    );
    await addBill(
      description: 'Salário Cliente X',
      type: 'receber',
      value: 5000.00,
      dueDate: DateTime.now().add(const Duration(days: 10)),
    );
  }

  // --- MÉTODOS PARA MODIFICAR O ESTADO (CRUD) ---

  Future<void> addBill({
    required String description,
    required String type,
    required double value,
    required DateTime dueDate,
  }) async {
    final db = await DatabaseHelper().database;
    final bill = Bill(
        description: description, type: type, value: value, dueDate: dueDate);
    await db.insert('bills', bill.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    await loadBills(); // Recarrega a lista para atualizar a UI
  }

  Future<void> updateBill(Bill bill) async {
    final db = await DatabaseHelper().database;
    await db
        .update('bills', bill.toMap(), where: 'id = ?', whereArgs: [bill.id]);
    await loadBills();
  }

  Future<void> deleteBill(int id) async {
    final db = await DatabaseHelper().database;
    await db.delete('bills', where: 'id = ?', whereArgs: [id]);
    await loadBills();
  }

  Future<void> markAsPaid(Bill bill) async {
    bill.isPaid = true;
    await updateBill(bill);
  }
}

// O Provider que a nossa UI vai usar para acessar o Notifier
final billProvider =
    StateNotifierProvider<BillNotifier, AsyncValue<List<Bill>>>((ref) {
  return BillNotifier();
});
