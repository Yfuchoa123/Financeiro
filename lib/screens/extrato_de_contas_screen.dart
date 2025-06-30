// lib/screens/extrato_de_contas_screen.dart

import 'package:flutter/material.dart';
// ADICIONADO: Import para a nossa AppBar customizada
import 'package:meu_financeiro_pessoal/widgets/custom_app_bar.dart';

class ExtratoDeContasScreen extends StatelessWidget {
  const ExtratoDeContasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // REMOVIDO: A AppBar antiga que estava aqui.
      // appBar: AppBar(
      //   title: const Text('Extrato de contas'),
      //   backgroundColor: const Color(0xFF00BFA5),
      //   foregroundColor: Colors.white,
      // ),

      // ADICIONADO: A nova AppBar customizada que já tem a lógica de favoritos.
      appBar: const CustomAppBar(title: 'Extrato de contas'),

      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLeftPanel(),
          _buildRightPanel(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFE91E63),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // Painel da Esquerda (Filtros e Resumo)
  Widget _buildLeftPanel() {
    return SizedBox(
      width: 350,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Seletor de conta e data
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Seletor de Conta
                    DropdownButtonFormField<String>(
                      value: 'conta_corrente',
                      items: const [
                        DropdownMenuItem(
                          value: 'conta_corrente',
                          child: Row(
                            children: [
                              Icon(Icons.account_balance_wallet_outlined),
                              SizedBox(width: 8),
                              Text('Conta corrente'),
                            ],
                          ),
                        ),
                      ],
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        contentPadding: const EdgeInsets.symmetric(vertical: 4),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.edit, size: 20),
                          onPressed: () {
                            // Ação para editar conta
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Seletor de data
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.arrow_left),
                            onPressed: () {}),
                        const Text('26 jun 2025',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        IconButton(
                            icon: const Icon(Icons.arrow_right),
                            onPressed: () {}),
                        const Icon(Icons.calendar_today,
                            size: 20, color: Colors.grey),
                        const Icon(Icons.settings,
                            size: 20, color: Colors.grey),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Card de Situação da Conta
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                            child: Text(
                          'Situação confirmada/projetada (R\$)',
                          overflow: TextOverflow.ellipsis,
                        )),
                        IconButton(
                            icon: const Icon(Icons.info_outline, size: 16),
                            onPressed: () {})
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildSituationRow(
                        'Saldo anterior', '-12.312.524,67', '-12.312.524,67',
                        color: Colors.red),
                    _buildSituationRow('Receitas', '400.000,00', '400.000,00',
                        color: Colors.green),
                    _buildSituationRow(
                        'Transferências de ent...', '0,00', '0,00'),
                    _buildSituationRow('Despesas', '0,00', '0,00'),
                    _buildSituationRow(
                        'Transferências de saída', '0,00', '0,00'),
                    const Divider(height: 24),
                    _buildSituationRow('Resultado', '400.000,00', '400.000,00',
                        isBold: true, color: Colors.green),
                    const SizedBox(height: 8),
                    _buildSituationRow(
                        'Saldo final', '-11.912.524,67', '-11.912.524,67',
                        isBold: true, color: Colors.red),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSituationRow(String label, String value1, String value2,
      {bool isBold = false, Color? color}) {
    final style = TextStyle(
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      color: color ?? Colors.black87,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: Text(
            label,
            style: style.copyWith(color: Colors.black87),
            overflow: TextOverflow.ellipsis,
          )),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                    child:
                        Text(value1, style: style, textAlign: TextAlign.right)),
                Expanded(
                    child:
                        Text(value2, style: style, textAlign: TextAlign.right)),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Painel da Direita (Lançamentos)
  Widget _buildRightPanel() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Barra de filtro superior
            Card(
              elevation: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    const Text('Filtrar'),
                    const Spacer(),
                    IconButton(
                        icon: const Icon(Icons.monetization_on_outlined),
                        onPressed: () {}),
                    IconButton(
                        icon: const Icon(Icons.settings), onPressed: () {}),
                    IconButton(
                        icon: const Icon(Icons.fullscreen), onPressed: () {}),
                    IconButton(
                        icon: const Icon(Icons.download), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.print), onPressed: () {}),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Tabela de Lançamentos
            Card(
              elevation: 2,
              child: Column(
                children: [
                  _buildTransactionRow(
                    date: '25/06',
                    description: 'Saldo anterior',
                    balance: '-12.312.524,67',
                    isHeader: true,
                  ),
                  _buildTransactionRow(
                    date: 'hoje',
                    description: 'addsadas',
                    category: 'Outras Receitas',
                    value: '400.000,00',
                    balance: '-11.912.524,67',
                    statusColor: Colors.green,
                    isToday: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Legenda
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _LegendItem(color: Colors.pink, text: 'Pendentes'),
                _LegendItem(color: Colors.blue, text: 'Agendados'),
                _LegendItem(color: Colors.green, text: 'Confirmados'),
                _LegendItem(color: Colors.purple, text: 'Conciliados'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionRow({
    required String date,
    required String description,
    required String balance,
    String? category,
    String? value,
    Color? statusColor,
    bool isHeader = false,
    bool isToday = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Row(
              children: [
                if (statusColor != null)
                  Icon(Icons.circle, color: statusColor, size: 10),
                if (statusColor != null) const SizedBox(width: 8),
                Text(
                  date,
                  style: TextStyle(
                      fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                      color: isToday ? Colors.orange : Colors.black87),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(description,
                    style: TextStyle(
                        fontWeight:
                            isHeader ? FontWeight.bold : FontWeight.normal)),
                if (category != null)
                  Chip(
                    label: Text(category, style: const TextStyle(fontSize: 10)),
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  )
              ],
            ),
          ),
          if (value != null)
            SizedBox(
              width: 150,
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: const TextStyle(
                    color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ),
          SizedBox(
            width: 150,
            child: Text(
              balance,
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: balance.startsWith('-') ? Colors.red : Colors.green),
            ),
          ),
          SizedBox(
            width: 40,
            child: IconButton(
              icon: const Icon(Icons.more_vert, size: 20, color: Colors.grey),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String text;
  const _LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.circle, color: color, size: 12),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}
