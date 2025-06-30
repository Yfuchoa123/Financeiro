// lib/screens/cadastros/contas_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_financeiro_pessoal/models/conta_model.dart';
import 'package:meu_financeiro_pessoal/services/conta_service.dart';
import 'package:meu_financeiro_pessoal/widgets/custom_app_bar.dart';
import 'package:meu_financeiro_pessoal/modals/nova_conta_modal.dart';
import 'package:meu_financeiro_pessoal/modals/editar_conta_modal.dart';

class ContasScreen extends ConsumerWidget {
  const ContasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contasAsyncValue = ref.watch(contaProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Contas'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Barra superior com botão
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Exportar contas ativas')),
            ),
            const SizedBox(height: 16),
            // Conteúdo principal
            Expanded(
              child: contasAsyncValue.when(
                data: (contas) {
                  final contasCorrente =
                      contas.where((c) => c.type == 'corrente').toList();
                  final cartoes =
                      contas.where((c) => c.type == 'cartao').toList();

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle('Conta Corrente'),
                        const SizedBox(height: 16),
                        _buildAccountList(contasCorrente),
                        const SizedBox(height: 32),
                        _buildSectionTitle('Cartão de Crédito'),
                        const SizedBox(height: 16),
                        _buildAccountList(cartoes),
                      ],
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Erro: $err')),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context, builder: (context) => const NovaContaModal());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black54),
    );
  }

  Widget _buildAccountList(List<Conta> contas) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: contas.map((conta) => _AccountCard(conta: conta)).toList(),
    );
  }
}

// Card de cada conta
class _AccountCard extends ConsumerWidget {
  final Conta conta;
  const _AccountCard({required this.conta});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: 300,
        child: Column(
          children: [
            ListTile(
              leading: Icon(conta.type == 'corrente'
                  ? Icons.account_balance_wallet
                  : Icons.credit_card),
              title: Text(conta.name,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle:
                  Text('Saldo: R\$ ${conta.initialBalance.toStringAsFixed(2)}'),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'editar') {
                    showDialog(
                        context: context,
                        builder: (ctx) => EditarContaModal(conta: conta));
                  } else if (value == 'excluir') {
                    ref.read(contaProvider.notifier).deleteConta(conta.id!);
                  } else if (value == 'inativar') {
                    ref.read(contaProvider.notifier).toggleStatus(conta);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'editar', child: Text('Editar')),
                  PopupMenuItem(
                      value: 'inativar',
                      child: Text(conta.isActive ? 'Inativar' : 'Ativar')),
                  const PopupMenuItem(value: 'excluir', child: Text('Excluir')),
                ],
              ),
            ),
            if (!conta.isActive)
              Container(
                width: double.infinity,
                color: Colors.grey.withAlpha(50),
                padding: const EdgeInsets.all(8.0),
                child: const Center(
                    child: Text('CONTA INATIVA',
                        style: TextStyle(color: Colors.black54))),
              )
          ],
        ),
      ),
    );
  }
}
