// lib/screens/cartoes_de_credito_screen.dart

import 'package:flutter/material.dart';
import 'package:meu_financeiro_pessoal/widgets/custom_app_bar.dart';

class CartoesDeCreditoScreen extends StatefulWidget {
  const CartoesDeCreditoScreen({super.key});

  @override
  State<CartoesDeCreditoScreen> createState() => _CartoesDeCreditoScreenState();
}

class _CartoesDeCreditoScreenState extends State<CartoesDeCreditoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Cartões de crédito'),
      //   backgroundColor: const Color(0xFF00BFA5),
      //   foregroundColor: Colors.white,
      // ),
      appBar: const CustomAppBar(title: 'Cartões de crédito'),
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

  // Painel da Esquerda (Resumo da Fatura)
  Widget _buildLeftPanel() {
    return SizedBox(
      width: 350,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Seletor de Cartão e Mês
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      value: 'yuri_yuri',
                      items: const [
                        DropdownMenuItem(
                          value: 'yuri_yuri',
                          child: Row(
                            children: [
                              Icon(Icons.credit_card),
                              SizedBox(width: 8),
                              Text('Yuri Yuri'),
                            ],
                          ),
                        ),
                      ],
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.edit, size: 20),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.arrow_left),
                            onPressed: () {}),
                        const Text('julho 2025',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        IconButton(
                            icon: const Icon(Icons.arrow_right),
                            onPressed: () {}),
                        const Icon(Icons.calendar_today,
                            size: 20, color: Colors.grey),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Detalhes da Fatura
            Expanded(
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFaturaResumo(),
                        const SizedBox(height: 16),
                        _buildFaturaDetalhes(),
                        const SizedBox(height: 16),
                        _buildLimiteConta(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaturaResumo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Fatura atual (R\$)', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 8),
        _buildInfoRow('Fechamento', '10/07/2025'),
        _buildInfoRow('Vencimento', '20/07/2025'),
        _buildInfoRow('Saldo anterior', '10.000,00'),
        _buildInfoRow('Total pago', '0,00'),
        _buildInfoRow('Total', '43.526.375,17',
            isBold: true, color: Colors.green),
        _buildInfoRow('Valor a pagar', '43.536.375,17', isBold: true),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(onPressed: () {}, child: const Text('Fechar fatura')),
            TextButton(onPressed: () {}, child: const Text('Lançar pagamento')),
          ],
        )
      ],
    );
  }

  Widget _buildFaturaDetalhes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Detalhamento', style: TextStyle(color: Colors.grey)),
        const Divider(),
        _buildInfoRow('Outros créditos', '43.543.454,45', color: Colors.green),
        _buildInfoRow('Despesas', '0,00'),
        _buildInfoRow('Transferências', '-17.079,28', color: Colors.red),
        _buildInfoRow('Total conciliado', '0,00'),
        _buildInfoRow('Total não conciliado', '43.526.375,17', isBold: true),
        const SizedBox(height: 8),
        _buildInfoRow('Despesas fixas', '0,00'),
        // CORRIGIDO: Adicionado Expanded e Flexible para evitar o overflow
        Row(
          children: [
            const Flexible(
              flex: 3,
              child: Text('Parcelas futuras',
                  style: TextStyle(color: Colors.blue)),
            ),
            Flexible(
              flex: 4,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, alignment: Alignment.centerLeft),
                child: const Text('Antecipar parcelas'),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text('-187.872,08',
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLimiteConta() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Limite da conta', style: TextStyle(color: Colors.grey)),
        const Divider(),
        _buildInfoRow('Limite (Total)', '20.000,00'),
        _buildInfoRow('Utilizado', '43.348.503,09', color: Colors.orange),
        _buildInfoRow('Disponível', '43.368.503,09', color: Colors.green),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value,
      {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  color: color)),
        ],
      ),
    );
  }

  // Painel da Direita (Lançamentos da Fatura)
  Widget _buildRightPanel() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        const Text('Filtrar'),
                        const SizedBox(width: 8),
                        const Icon(Icons.search, size: 20, color: Colors.grey),
                        const Spacer(),
                        IconButton(
                            icon:
                                const Icon(Icons.dashboard_customize_outlined),
                            onPressed: () {}),
                        IconButton(
                            icon: const Icon(Icons.pie_chart_outline),
                            onPressed: () {}),
                        IconButton(
                            icon: const Icon(
                                Icons.align_horizontal_left_outlined),
                            onPressed: () {}),
                        IconButton(
                            icon: const Icon(Icons.fullscreen),
                            onPressed: () {}),
                        IconButton(
                            icon: const Icon(Icons.download), onPressed: () {}),
                        IconButton(
                            icon: const Icon(Icons.print), onPressed: () {}),
                      ],
                    ),
                  ),
                  _buildTransactionRow(
                      date: '24/06/25',
                      description: 'Aplicação programada 1/12',
                      tags: ['Conta corrente', 'Transferência'],
                      value: '-17.079,28',
                      isNegative: true),
                  _buildTransactionRow(
                      date: '25/06/25',
                      description: 'rdsffds',
                      tags: ['Investimentos/Rendimentos'],
                      value: '43.543.454,45',
                      isNegative: false),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _LegendItem(color: Colors.grey, text: 'Não conciliados'),
                _LegendItem(color: Colors.purple, text: 'Conciliados'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionRow({
    required String date,
    required String description,
    required List<String> tags,
    required String value,
    bool isNegative = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          const Icon(Icons.circle, color: Colors.grey, size: 10),
          const SizedBox(width: 8),
          SizedBox(width: 70, child: Text(date)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(description,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  children: tags
                      .map((tag) => Chip(
                            label:
                                Text(tag, style: const TextStyle(fontSize: 10)),
                            padding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                          ))
                      .toList(),
                )
              ],
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: isNegative ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 40,
            child: IconButton(
              icon: const Icon(Icons.more_vert, size: 20, color: Colors.grey),
              onPressed: () {},
            ),
          ),
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
