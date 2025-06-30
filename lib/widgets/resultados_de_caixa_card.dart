import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

class ResultadosDeCaixaCard extends StatefulWidget {
  const ResultadosDeCaixaCard({super.key});

  @override
  State<ResultadosDeCaixaCard> createState() => _ResultadosDeCaixaCardState();
}

class _ResultadosDeCaixaCardState extends State<ResultadosDeCaixaCard> {
  final List<BarChartGroupData> _barGroups = [
    BarChartGroupData(
      x: 0,
      barRods: [BarChartRodData(toY: 2231.32, color: Colors.blue, width: 16)],
    ),
    BarChartGroupData(
      x: 1,
      barRods: [BarChartRodData(toY: 0, color: Colors.yellow, width: 16)],
    ),
    BarChartGroupData(
      x: 2,
      barRods: [BarChartRodData(toY: -100, color: Colors.red, width: 16)],
    ),
    BarChartGroupData(
      x: 3,
      barRods: [BarChartRodData(toY: 2131.32, color: Colors.green, width: 16)],
    ),
  ];

  bool _showConta = true;
  bool _showContaCorrente = true;
  bool _showResiduoMetas = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resultados de caixa',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BarChart(
                BarChartData(
                  barGroups: _barGroups,
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 60,
                        getTitlesWidget: (value, meta) {
                          Widget text;
                          switch (value.toInt()) {
                            case 0:
                              text = const Text('Conta',
                                  style: TextStyle(fontSize: 10));
                              break;
                            case 1:
                              text = const Text('Entradas',
                                  style: TextStyle(fontSize: 10));
                              break;
                            case 2:
                              text = const Text('Saídas',
                                  style: TextStyle(fontSize: 10));
                              break;
                            case 3:
                              text = const Text('Resultado',
                                  style: TextStyle(fontSize: 10));
                              break;
                            default:
                              text = const Text('');
                              break;
                          }
                          return SideTitleWidget(
                            meta: meta, // <--- ESTA LINHA FOI ADICIONADA
                            space: 4,
                            child: Transform.rotate(
                              angle: -math.pi / 4,
                              alignment: Alignment.topRight,
                              child: text,
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value == 0) return const Text('0');
                          if (value == 1000) return const Text('1 mil');
                          if (value == 2000) return const Text('2 mil');
                          return const Text('');
                        },
                        reservedSize: 40,
                      ),
                    ),
                  ),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  barTouchData: BarTouchData(enabled: false),
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 2500,
                  minY: -200,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    SizedBox(width: 32),
                    Expanded(child: Text('')),
                    SizedBox(
                        width: 80,
                        child: Text('Entradas',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 12))),
                    SizedBox(
                        width: 80,
                        child: Text('Saídas',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 12))),
                    SizedBox(
                        width: 80,
                        child: Text('Resultado',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 12))),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Checkbox(
                        value: _showConta,
                        onChanged: (val) {
                          setState(() {
                            _showConta = val!;
                          });
                        }),
                    const Expanded(child: Text('Conta')),
                    SizedBox(
                        width: 80,
                        child: Text('2.231,32', textAlign: TextAlign.right)),
                    SizedBox(
                        width: 80,
                        child: Text('-100,00',
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.red[700]))),
                    SizedBox(
                        width: 80,
                        child: Text('2.131,32',
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.green[700]))),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        value: _showContaCorrente,
                        onChanged: (val) {
                          setState(() {
                            _showContaCorrente = val!;
                          });
                        }),
                    const Expanded(child: Text('Conta corrente')),
                    SizedBox(
                        width: 80,
                        child: Text('2.231,32', textAlign: TextAlign.right)),
                    SizedBox(
                        width: 80,
                        child: Text('-100,00',
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.red[700]))),
                    SizedBox(
                        width: 80,
                        child: Text('2.131,32',
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.green[700]))),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        value: _showResiduoMetas,
                        onChanged: (val) {
                          setState(() {
                            _showResiduoMetas = val!;
                          });
                        }),
                    const Expanded(child: Text('Resíduo de metas')),
                    const SizedBox(
                        width: 80,
                        child: Text('0,00', textAlign: TextAlign.right)),
                    SizedBox(
                        width: 80,
                        child: Text('-100,00',
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.red[700]))),
                    SizedBox(
                        width: 80,
                        child: Text('-100,00',
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.red[700]))),
                  ],
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const SizedBox(width: 32),
                const Expanded(
                    child: Text('Total',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                SizedBox(
                    width: 80,
                    child: Text('2.231,32',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold))),
                SizedBox(
                    width: 80,
                    child: Text('-200,00',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.red[700],
                            fontWeight: FontWeight.bold))),
                SizedBox(
                    width: 80,
                    child: Text('2.031,32',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
