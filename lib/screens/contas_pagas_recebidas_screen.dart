// lib/screens/contas_pagas_recebidas_screen.dart
import 'package:flutter/material.dart';
import 'package:meu_financeiro_pessoal/widgets/custom_app_bar.dart';

class ContasPagasRecebidasScreen extends StatelessWidget {
  const ContasPagasRecebidasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Adicionado DefaultTabController
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Contas pagas e recebidas'),
        //   bottom: const TabBar(
        //     tabs: [
        //       Tab(text: 'PAGAS'),
        //       Tab(text: 'RECEBIDAS'),
        //     ],
        //   ),
        // ),
        // ADICIONE ISTO NO LUGAR:
        appBar: const CustomAppBar(title: 'Contas pagas e recebidas'),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLeftPanel(),
            Expanded(
              child: TabBarView(
                children: [
                  _buildContentPanel(
                    emptyMessage:
                        'Nenhuma despesa confirmada no período escolhido.',
                    subMessage:
                        'Você pode escolher outro período ou lançar uma nova despesa.',
                    actionText: 'Incluir despesa',
                  ),
                  _buildContentPanel(
                    emptyMessage:
                        'Nenhuma receita confirmada no período escolhido.',
                    subMessage:
                        'Você pode escolher outro período ou lançar uma nova receita.',
                    actionText: 'Incluir receita',
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFFE91E63),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  // O resto do código do arquivo permanece o mesmo
  Widget _buildLeftPanel() {
    return SizedBox(
      width: 350,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.arrow_left), onPressed: () {}),
                    const Text('23 jun - 29 jun',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    IconButton(
                        icon: const Icon(Icons.arrow_right), onPressed: () {}),
                    const Icon(Icons.calendar_today, size: 20),
                    const SizedBox(width: 8),
                    const Icon(Icons.settings, size: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Resultado do período',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 16),
                    _buildResultRow('Pago', '0,00'),
                    const SizedBox(height: 8),
                    _buildResultRow('Recebido', '0,00'),
                    const Divider(height: 24),
                    _buildResultRow('Resultado', '0,00', isBold: true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                color: Colors.grey[700],
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        Text(value,
            style: TextStyle(
                color: Colors.black,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }

  Widget _buildContentPanel({
    required String emptyMessage,
    required String subMessage,
    required String actionText,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
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
                      icon: const Icon(Icons.settings), onPressed: () {}),
                  IconButton(
                      icon: const Icon(Icons.fullscreen), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.print), onPressed: () {}),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Card(
              elevation: 2,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.grey[300],
                    padding: const EdgeInsets.all(8.0),
                    child: const Center(
                      child: Text(
                        'Exibindo apenas lançamentos conciliados',
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.thumb_up_alt_outlined,
                              size: 80, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text(emptyMessage,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(subMessage,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[600])),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () {},
                            child: Text(actionText,
                                style: const TextStyle(
                                    color: Color(0xFF00BFA5),
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.circle, color: Colors.green[300], size: 12),
                  const SizedBox(width: 8),
                  const Text('Confirmados'),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.circle, color: Colors.grey[400], size: 12),
                  const SizedBox(width: 8),
                  const Text('Conciliados'),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
