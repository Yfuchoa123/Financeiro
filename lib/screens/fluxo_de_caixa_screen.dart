// lib/screens/fluxo_de_caixa_screen.dart

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:meu_financeiro_pessoal/widgets/custom_app_bar.dart';

class FluxoDeCaixaScreen extends StatefulWidget {
  const FluxoDeCaixaScreen({super.key});

  @override
  State<FluxoDeCaixaScreen> createState() => _FluxoDeCaixaScreenState();
}

class _FluxoDeCaixaScreenState extends State<FluxoDeCaixaScreen> {
  // State variables for checkboxes
  bool _contaCorrenteChecked = true;
  bool _considerarPendentes = false;
  bool _desconsiderarIntraconta = false;

  final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Fluxo de caixa'),
      //   backgroundColor: const Color(0xFF00BFA5),
      //   foregroundColor: Colors.white,
      //   actions: [
      //     // Mantendo os actions consistentes com outras telas
      //     IconButton(icon: const Icon(Icons.search), onPressed: () {}),
      //     IconButton(icon: const Icon(Icons.help_outline), onPressed: () {}),
      //     IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
      //   ],
      // ),
      // ADICIONE ISTO NO LUGAR:
      appBar: const CustomAppBar(title: 'Fluxo de caixa'),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLeftPanel(),
          _buildRightPanel(),
        ],
      ),
    );
  }

  // Painel da Esquerda (Filtros)
  Widget _buildLeftPanel() {
    return SizedBox(
      width: 350,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Seletor de data
            Row(
              children: [
                IconButton(
                    icon: const Icon(Icons.arrow_left), onPressed: () {}),
                const Text('23 jun - 29 jun',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                IconButton(
                    icon: const Icon(Icons.arrow_right), onPressed: () {}),
                const Spacer(),
                const Icon(Icons.calendar_today, size: 20),
                const SizedBox(width: 8),
                const Icon(Icons.settings, size: 20),
              ],
            ),
            const SizedBox(height: 24),
            // Card de Saldo
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text('Saldo em 29 jun',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Checkbox(
                          value: _contaCorrenteChecked,
                          onChanged: (val) {
                            setState(() {
                              _contaCorrenteChecked = val!;
                            });
                          },
                        ),
                        const Text('Conta corrente'),
                        const Spacer(),
                        Text('-12.312.424,67',
                            style: TextStyle(color: Colors.red[700])),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const SizedBox(width: 16),
                        const Icon(Icons.circle, size: 8),
                        const SizedBox(width: 8),
                        const Text('Total',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const Spacer(),
                        Text('-12.312.424,67',
                            style: TextStyle(
                                color: Colors.red[700],
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Painel da Direita (Conteúdo Principal)
  Widget _buildRightPanel() {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildFilterBar(),
            const SizedBox(height: 16),
            _buildTableCard(),
            const SizedBox(height: 16),
            _buildLineChartCard(),
            const SizedBox(height: 16),
            _buildBarChartCard(),
          ],
        ),
      ),
    );
  }

  // Barra de filtros do painel direito
  Widget _buildFilterBar() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Checkbox(
              value: _considerarPendentes,
              onChanged: (val) => setState(() => _considerarPendentes = val!),
            ),
            const Text('Considerar lançamentos pendentes'),
            const SizedBox(width: 24),
            Checkbox(
              value: _desconsiderarIntraconta,
              onChanged: (val) =>
                  setState(() => _desconsiderarIntraconta = val!),
            ),
            const Text('Desconsiderar transferências intraconta'),
            const Spacer(),
            IconButton(icon: const Icon(Icons.fullscreen), onPressed: () {}),
            IconButton(icon: const Icon(Icons.print), onPressed: () {}),
          ],
        ),
      ),
    );
  }

  // Card com a Tabela de Fluxo de Caixa
  Widget _buildTableCard() {
    final textStyle = TextStyle(color: Colors.grey[800]);
    final boldGreen =
        TextStyle(color: Colors.green[700], fontWeight: FontWeight.bold);
    final boldRed =
        TextStyle(color: Colors.red[700], fontWeight: FontWeight.bold);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: DataTable(
            columnSpacing: 32,
            columns: const [
              DataColumn(label: Text('')),
              DataColumn(label: Text('Entradas (R\$)'), numeric: true),
              DataColumn(label: Text('Saídas (R\$)'), numeric: true),
              DataColumn(label: Text('Resultado (R\$)'), numeric: true),
              DataColumn(label: Text('Saldo (R\$)'), numeric: true),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('Saldo anterior', style: textStyle)),
                const DataCell(Text('')),
                const DataCell(Text('')),
                const DataCell(Text('')),
                DataCell(Text('0,00', style: textStyle)),
              ]),
              DataRow(cells: [
                DataCell(Text('24/06/2025',
                    style: TextStyle(
                        color: Colors.blue[700], fontWeight: FontWeight.bold))),
                DataCell(Text('2.231,32', style: boldGreen)),
                DataCell(Text('-100,00', style: boldRed)),
                DataCell(Text('2.131,32', style: boldGreen)),
                DataCell(Text('2.131,32', style: boldGreen)),
              ]),
              DataRow(cells: [
                DataCell(Text('25/06/2025',
                    style: TextStyle(
                        color: Colors.blue[700], fontWeight: FontWeight.bold))),
                DataCell(Text('0,00', style: textStyle)),
                DataCell(Text('-12.314.555,99', style: boldRed)),
                DataCell(Text('-12.314.555,99', style: boldRed)),
                DataCell(Text('-12.312.424,67', style: boldRed)),
              ]),
              DataRow(cells: [
                const DataCell(Text('Total',
                    style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text('2.231,32', style: boldGreen)),
                DataCell(Text('-12.314.655,99', style: boldRed)),
                DataCell(Text('-12.312.424,67', style: boldRed)),
                const DataCell(Text('')),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  // Card com o Gráfico de Linha
  Widget _buildLineChartCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Fluxo de caixa',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[300]!))),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(fontSize: 12);
                          String text = '';
                          switch (value.toInt()) {
                            case 0:
                              text = '23 jun';
                              break;
                            case 1:
                              text = '24 jun';
                              break;
                            case 2:
                              text = '25 jun';
                              break;
                            case 3:
                              text = '26 jun';
                              break;
                            case 4:
                              text = '27 jun';
                              break;
                            case 5:
                              text = '28 jun';
                              break;
                            case 6:
                              text = '29 jun';
                              break;
                          }
                          return SideTitleWidget(
                              meta: meta, child: Text(text, style: style));
                        },
                        interval: 1,
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 0),
                        FlSpot(1, 0),
                        FlSpot(2, -1),
                        FlSpot(3, -1),
                        FlSpot(4, -1),
                        FlSpot(5, -1),
                        FlSpot(6, -1),
                      ],
                      isCurved: false,
                      color: Colors.red,
                      barWidth: 3,
                      dotData: const FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Card com o Gráfico de Barras
  Widget _buildBarChartCard() {
    return Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Resultado de caixa',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              SizedBox(
                height: 200,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[300]!))),
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const style = TextStyle(fontSize: 12);
                            String text = '';
                            switch (value.toInt()) {
                              case 0:
                                text = '24 jun';
                                break;
                              case 1:
                                text = '25 jun';
                                break;
                            }
                            return SideTitleWidget(
                                meta: meta, child: Text(text, style: style));
                          },
                        ),
                      ),
                    ),
                    barGroups: [
                      BarChartGroupData(x: 0, barRods: [
                        BarChartRodData(
                          toY: 2231.32,
                          color: Colors.green,
                          width: 25,
                          borderRadius:
                              BorderRadius.zero, // <-- LINHA ADICIONADA
                        ),
                        BarChartRodData(
                          toY: -100.00,
                          color: Colors.red,
                          width: 25,
                          borderRadius:
                              BorderRadius.zero, // <-- LINHA ADICIONADA
                        ),
                      ]),
                      BarChartGroupData(x: 1, barRods: [
                        BarChartRodData(
                          toY: -12314555.99,
                          color: Colors.red,
                          width: 25,
                          borderRadius:
                              BorderRadius.zero, // <-- LINHA ADICIONADA
                        ),
                      ]),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
