// lib/screens/lancamentos_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_financeiro_pessoal/models/lancamento_model.dart';
import 'package:meu_financeiro_pessoal/services/lancamento_service.dart';
import 'package:meu_financeiro_pessoal/widgets/custom_app_bar.dart';
import 'package:intl/intl.dart';

class LancamentosScreen extends ConsumerWidget {
  const LancamentosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lancamentosAsyncValue = ref.watch(lancamentoProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Lançamentos de caixa'),
      body: Row(
        children: [
          // Painel de Resumo (Esquerda) - AGORA COM O CONTEÚDO CORRETO
          SizedBox(
            width: 350,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Seletor de data
                  Row(
                    children: [
                      IconButton(
                          icon: const Icon(Icons.arrow_left), onPressed: () {}),
                      const Text('23 jun - 29 jun',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      IconButton(
                          icon: const Icon(Icons.arrow_right),
                          onPressed: () {}),
                      const Spacer(),
                      const Icon(Icons.calendar_today, size: 20),
                      const SizedBox(width: 8),
                      const Icon(Icons.settings, size: 20),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Saldos de caixa
                  const Text(
                    'Saldos de caixa',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Checkbox(value: true, onChanged: (val) {}),
                      const Expanded(child: Text('Conta corrente')),
                      Text('2.131,32',
                          style: TextStyle(color: Colors.green[700])),
                      const SizedBox(width: 16),
                      Text('2.131,32',
                          style: TextStyle(color: Colors.green[700])),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const SizedBox(width: 32),
                      const Expanded(
                          child: Text('Total',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      Text('2.131,32',
                          style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold)),
                      const SizedBox(width: 16),
                      Text('2.131,32',
                          style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Resultados (R$)
                  const Text(
                    'Resultados (R\$)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('Entradas', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 4),
                  const Text('Receitas', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 4),
                  const Text('Transferências',
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 4),
                  const Text('Saídas', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 4),
                  const Text('Despesas', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 4),
                  const Text('Transferências',
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 4),
                  const Text('Resultado',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text('2.131,32',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),

          // Lista de Lançamentos (Direita)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Barra de filtro
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Filtrar',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                          icon: const Icon(Icons.settings), onPressed: () {}),
                      IconButton(
                          icon: const Icon(Icons.fullscreen), onPressed: () {}),
                      IconButton(
                          icon: const Icon(Icons.print), onPressed: () {}),
                      IconButton(
                          icon: const Icon(Icons.file_download),
                          onPressed: () {}),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Lista de Lançamentos
                  Expanded(
                    child: lancamentosAsyncValue.when(
                      data: (lancamentos) => ListView.separated(
                        itemCount: lancamentos.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          final lancamento = lancamentos[index];
                          return _buildLancamentoTile(lancamento);
                        },
                      ),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (err, stack) => Center(child: Text('Erro: $err')),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLancamentoTile(Lancamento lancamento) {
    final isNegative = lancamento.value < 0;
    final formattedDate = DateFormat('dd/MM/yy').format(lancamento.date);

    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(formattedDate,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
        ],
      ),
      title: Text(lancamento.description,
          style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(
          'Conta ID: ${lancamento.accountId} - Cat: ${lancamento.categoryName}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'R\$ ${lancamento.value.toStringAsFixed(2)}',
            style: TextStyle(
              color: isNegative ? Colors.red[700] : Colors.green[700],
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
    );
  }
}
