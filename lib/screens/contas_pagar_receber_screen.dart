// lib/screens/contas_pagar_receber_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:meu_financeiro_pessoal/models/bill_model.dart';
import 'package:meu_financeiro_pessoal/services/bill_service.dart';
import 'package:meu_financeiro_pessoal/widgets/custom_app_bar.dart';

class ContasPagarReceberScreen extends ConsumerWidget {
  const ContasPagarReceberScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observa o nosso novo provider de contas
    final billsAsyncValue = ref.watch(billProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Contas a pagar e receber',
          // A TabBar é adicionada diretamente na AppBar customizada
          bottom: TabBar(
            // As cores são herdadas do tema definido no main.dart
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white.withOpacity(0.7),
            tabs: const [
              Tab(text: 'A PAGAR'),
              Tab(text: 'A RECEBER'),
            ],
          ),
        ),
        // O .when trata os diferentes estados: carregando, erro e sucesso
        body: billsAsyncValue.when(
          data: (bills) {
            // Filtra as contas que ainda não foram pagas
            final aPagar = bills
                .where((bill) => bill.type == 'pagar' && !bill.isPaid)
                .toList();
            final aReceber = bills
                .where((bill) => bill.type == 'receber' && !bill.isPaid)
                .toList();

            return TabBarView(
              children: [
                _buildBillList(aPagar, ref, 'pagar'),
                _buildBillList(aReceber, ref, 'receber'),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) =>
              Center(child: Text('Erro ao carregar contas: $err')),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // No futuro, aqui abriremos um modal para adicionar uma nova conta
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  // Widget que constrói a lista de contas para cada aba
  Widget _buildBillList(List<Bill> bills, WidgetRef ref, String type) {
    if (bills.isEmpty) {
      return Center(
        child:
            Text('Nenhuma conta a ${type == 'pagar' ? 'pagar' : 'receber'}.'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: bills.length,
      itemBuilder: (context, index) {
        final bill = bills[index];
        final formattedDate = DateFormat('dd/MM/yyyy').format(bill.dueDate);
        final isReceber = bill.type == 'receber';

        return Card(
          elevation: 1,
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            leading: IconButton(
              icon: const Icon(Icons.check_circle_outline, color: Colors.grey),
              tooltip: 'Marcar como pago/recebido',
              onPressed: () {
                // Ação para marcar a conta como paga
                ref.read(billProvider.notifier).markAsPaid(bill);
              },
            ),
            title: Text(bill.description),
            subtitle: Text('Vencimento: $formattedDate'),
            trailing: Text(
              'R\$ ${bill.value.toStringAsFixed(2)}',
              style: TextStyle(
                color: isReceber ? Colors.green[700] : Colors.red[700],
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        );
      },
    );
  }
}
