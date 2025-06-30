// lib/screens/metas_de_orcamento_screen.dart

import 'package:flutter/material.dart';

class MetasDeOrcamentoScreen extends StatelessWidget {
  const MetasDeOrcamentoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Metas de orçamento'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'DESPESAS'),
              Tab(text: 'RECEITAS'),
              Tab(text: 'INVESTIMENTOS'),
              Tab(text: 'EVOLUÇÃO'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildDespesasTab(),
            _buildReceitasTab(),
            _buildInvestimentosTab(),
            _buildEvolucaoTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFFE91E63),
          child: const Icon(Icons.edit, color: Colors.white),
        ),
      ),
    );
  }

  // Aba de Despesas
  Widget _buildDespesasTab() {
    return _buildTabContent(
      leftPanel: _buildDespesasLeftPanel(),
      rightPanel: _buildDespesasList(),
    );
  }

  Widget _buildDespesasLeftPanel() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: const Icon(Icons.arrow_left), onPressed: () {}),
                const Text('junho 2025',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                IconButton(
                    icon: const Icon(Icons.arrow_right), onPressed: () {}),
                const Icon(Icons.calendar_today, size: 20, color: Colors.grey),
                const Icon(Icons.settings, size: 20, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Categorias definidas',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            LinearProgressIndicator(
                value: 0.0,
                backgroundColor: Colors.grey[300],
                color: Colors.blue),
            const Align(alignment: Alignment.centerRight, child: Text('0,00%')),
            const SizedBox(height: 16),
            _buildInfoRow('Total das metas', 'R\$ 100,00'),
            _buildInfoRow('Total confirmado', 'R\$ 0,00'),
            _buildInfoRow('Total a realizar', 'R\$ 100,00'),
            const Divider(height: 24),
            const Text('Total do mês',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            LinearProgressIndicator(
                value: 1.0,
                backgroundColor: Colors.grey[300],
                color: Colors.red),
            Align(
                alignment: Alignment.centerRight,
                child: Text('12.314.765,99%',
                    style: TextStyle(color: Colors.red))),
            const SizedBox(height: 16),
            _buildInfoRow('Meta definida', 'R\$ 100,00'),
            _buildInfoRow('Total confirmado', '-R\$ 12.314.755,99',
                valueColor: Colors.red),
            _buildInfoRow('Excedente', '-R\$ 12.314.655,99',
                valueColor: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildDespesasList() {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                const Text('Situação confirmada'),
                const Spacer(),
                const Text('Filtrar'),
                IconButton(
                    icon: const Icon(Icons.remove_red_eye_outlined),
                    onPressed: () {}),
                IconButton(icon: const Icon(Icons.print), onPressed: () {}),
              ],
            ),
          ),
          _buildDespesaItem(
              'Transporte', '0,00%', '100,00', '0,00', '100,00', '0,00')
        ],
      ),
    );
  }

  Widget _buildDespesaItem(String categoria, String percent, String meta,
      String realizado, String aRealizar, String excedente) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(categoria, style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          LinearProgressIndicator(
              value: 0.0,
              backgroundColor: Colors.grey[300],
              color: Colors.blue),
          Align(alignment: Alignment.centerLeft, child: Text(percent)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildValorItem('Meta', 'R\$ $meta'),
              _buildValorItem('Realizado', 'R\$ $realizado'),
              _buildValorItem('A realizar', 'R\$ $aRealizar'),
              _buildValorItem('Excedente', 'R\$ $excedente',
                  valueColor: Colors.red),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildValorItem(String label, String value, {Color? valueColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        Text(value,
            style: TextStyle(
                color: valueColor ?? Colors.black,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  // Aba de Receitas
  Widget _buildReceitasTab() {
    return _buildTabContent(
      leftPanel: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(icon: const Icon(Icons.arrow_left), onPressed: () {}),
              const Text('junho 2025',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              IconButton(icon: const Icon(Icons.arrow_right), onPressed: () {}),
              const Icon(Icons.calendar_today, size: 20, color: Colors.grey),
              const Icon(Icons.settings, size: 20, color: Colors.grey),
            ],
          ),
        ),
      ),
      rightPanel: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              const Text('Situação confirmada'),
              const Spacer(),
              const Text('Filtrar'),
              IconButton(
                  icon: const Icon(Icons.remove_red_eye_outlined),
                  onPressed: () {}),
              IconButton(icon: const Icon(Icons.print), onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }

  // Aba de Investimentos
  Widget _buildInvestimentosTab() {
    return _buildTabContent(
      leftPanel: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(icon: const Icon(Icons.arrow_left), onPressed: () {}),
              const Text('junho 2025',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              IconButton(icon: const Icon(Icons.arrow_right), onPressed: () {}),
              const Icon(Icons.calendar_today, size: 20, color: Colors.grey),
              const Icon(Icons.settings, size: 20, color: Colors.grey),
            ],
          ),
        ),
      ),
      rightPanel: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            const Text('Sem metas de investimentos definidas no período.',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            const Text('Escolha um período diferente ou defina uma nova meta.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00BFA5),
                  foregroundColor: Colors.white),
              child: const Text('Definir metas'),
            )
          ],
        ),
      ),
    );
  }

  // Aba de Evolução
  Widget _buildEvolucaoTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Barra de Filtro Superior
          Card(
            elevation: 2,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  const Text('Intervalo:'),
                  const SizedBox(width: 8),
                  const Text('Mensal'),
                  const SizedBox(width: 24),
                  const Text('Início:'),
                  const SizedBox(width: 8),
                  const Text('janeiro 2025'),
                  const SizedBox(width: 24),
                  const Text('Período:'),
                  const SizedBox(width: 8),
                  const Text('6 meses'),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        foregroundColor: Colors.white),
                    child: const Text('Carregar'),
                  ),
                  const Spacer(),
                  const Text('Filtrar'),
                  IconButton(
                      icon: const Icon(Icons.cancel_outlined),
                      onPressed: () {}),
                  IconButton(
                      icon: const Icon(Icons.check_box_outline_blank),
                      onPressed: () {}),
                  IconButton(
                      icon: const Icon(Icons.download), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.print), onPressed: () {}),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Tabela de Evolução
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Card(
                elevation: 2,
                child: DataTable(
                  dataRowMinHeight: 60.0,
                  dataRowMaxHeight: 70.0,
                  columnSpacing: 38.0,
                  columns: const [
                    DataColumn(label: Text('Realizado')),
                    DataColumn(label: Text('Jan/25')),
                    DataColumn(label: Text('Fev/25')),
                    DataColumn(label: Text('Mar/25')),
                    DataColumn(label: Text('Abr/25')),
                    DataColumn(label: Text('Mai/25')),
                    DataColumn(label: Text('Jun/25')),
                    DataColumn(label: Text('Média')),
                    DataColumn(label: Text('Total')),
                  ],
                  rows: _buildEvolucaoRows(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DataRow> _buildEvolucaoRows() {
    return [
      _createEvolucaoRow('Receitas', isHeader: true, meta: [
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00'
      ], realizado: [
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00'
      ]),
      _createEvolucaoRow('Despesas', isHeader: true, meta: [
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '-100,00',
        '-16,67',
        '-100,00'
      ], realizado: [
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00'
      ]),
      _createEvolucaoRow('Transporte', isSubHeader: true, meta: [
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '-100,00',
        '-16,67',
        '-100,00'
      ], realizado: [
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00'
      ]),
      _createEvolucaoRow('Investimentos', isHeader: true, meta: [
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00'
      ], realizado: [
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00'
      ]),
      _createEvolucaoRow('Resultado', isHeader: true, meta: [
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '-100,00',
        '-16,67',
        '-100,00'
      ], realizado: [
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00',
        '0,00'
      ]),
    ];
  }

  DataRow _createEvolucaoRow(String title,
      {bool isHeader = false,
      bool isSubHeader = false,
      required List<String> meta,
      required List<String> realizado}) {
    final titleStyle =
        TextStyle(fontWeight: isHeader ? FontWeight.bold : FontWeight.normal);
    final rowColor = isHeader
        ? (title == 'Investimentos'
            ? Colors.blue[50]
            : (title == 'Despesas'
                ? Colors.red[50]
                : (title == 'Receitas' ? Colors.green[50] : null)))
        : null;

    Widget titleWidget = Text(title, style: titleStyle);
    if (isSubHeader) {
      titleWidget = Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: titleWidget,
      );
    }

    return DataRow(color: WidgetStateProperty.all(rowColor), cells: [
      DataCell(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          titleWidget,
          Text('Meta', style: TextStyle(color: Colors.grey[600])),
          Text('Realizado'),
        ],
      )),
      for (int i = 0; i < meta.length; i++)
        DataCell(Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(meta[i], style: TextStyle(color: Colors.grey[600])),
            Text(realizado[i]),
          ],
        )),
    ]);
  }

  // Layout genérico para as abas
  Widget _buildTabContent(
      {required Widget leftPanel, required Widget rightPanel}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 350, child: leftPanel),
          const SizedBox(width: 16),
          Expanded(child: rightPanel),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.black54)),
        Text(value,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: valueColor ?? Colors.black87)),
      ],
    );
  }
}
