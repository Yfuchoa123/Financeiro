// lib/widgets/fluxo_de_caixa_card.dart

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class FluxoDeCaixaCard extends StatefulWidget {
  const FluxoDeCaixaCard({super.key});

  @override
  State<FluxoDeCaixaCard> createState() => _FluxoDeCaixaCardState();
}

class _FluxoDeCaixaCardState extends State<FluxoDeCaixaCard> {
  final List<FlSpot> _saldoData = [
    const FlSpot(0, 0),
    const FlSpot(7, 0),
    const FlSpot(14, 0),
    const FlSpot(21, -100),
    const FlSpot(28, -100),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                const Text(
                  'Fluxo de caixa',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_left, size: 20),
                      Text('jun 25', style: TextStyle(fontSize: 14)),
                      Icon(Icons.arrow_right, size: 20),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Flexible(
              fit: FlexFit.tight,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    drawHorizontalLine: true,
                    horizontalInterval: 100.0,
                    getDrawingHorizontalLine: (value) {
                      // CORRIGIDO: de withOpacity(0.3) para withAlpha(77)
                      return FlLine(
                        color: Colors.grey
                            .withAlpha(77), // Aproximadamente 30% de opacidade
                        strokeWidth: 0.5,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return const Text('02 jun.');
                            case 28:
                              return const Text('30 jun.');
                            default:
                              return const Text('');
                          }
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          if (value == 0) return const Text('0');
                          if (value == -100) return const Text('-100');
                          if (value == 1000) return const Text('1 mil');
                          if (value == 2000) return const Text('2 mil');
                          if (value == 3000) return const Text('3 mil');
                          return const Text('');
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: 28,
                  minY: -200,
                  maxY: 3000,
                  lineBarsData: [
                    LineChartBarData(
                      spots: _saldoData,
                      isCurved: false,
                      color: const Color(0xFFE91E63),
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (val) {}),
                    const Text('Conta corrente'),
                    const Spacer(),
                    Text('2.131,32',
                        style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (val) {}),
                    const Text('Saldo de resíduo de metas'),
                    const Spacer(),
                    Text('-100,00',
                        style: TextStyle(
                            color: Colors.red[700],
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    const Text('Total',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Text('R\$ 2.031,32',
                        style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
