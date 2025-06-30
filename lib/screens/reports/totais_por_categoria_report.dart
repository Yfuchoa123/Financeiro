// lib/screens/reports/totais_por_categoria_report.dart

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:meu_financeiro_pessoal/widgets/custom_app_bar.dart';

class TotaisPorCategoriaReport extends StatelessWidget {
  const TotaisPorCategoriaReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Relatórios / Totais por categoria'),
      //   backgroundColor: const Color(0xFF00BFA5),
      //   foregroundColor: Colors.white,
      // ),
      // ADICIONE ISTO NO LUGAR:
      appBar: const CustomAppBar(title: 'Relatórios / Totais por categoria'),
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

  // Painel da Esquerda (Resumo)
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.arrow_left),
                            onPressed: () {}),
                        const Expanded(
                          child: Text(
                            'junho 2025',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        IconButton(
                            icon: const Icon(Icons.arrow_right),
                            onPressed: () {}),
                        const Icon(Icons.calendar_today,
                            size: 20, color: Colors.grey),
                        const Icon(Icons.settings,
                            size: 20, color: Colors.grey),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildResumoRow(
                        'Receitas', 'R\$ 9.910.212.653,96', Colors.green),
                    const SizedBox(height: 8),
                    _buildResumoRow(
                        'Despesas', '-R\$ 12.314.755,99', Colors.red),
                    const Divider(height: 24),
                    _buildResumoRow(
                        'Total', 'R\$ 9.897.897.897,97', Colors.green,
                        isBold: true),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {},
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Visão de caixa'),
                    Icon(Icons.arrow_forward, size: 16),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildResumoRow(String label, String value, Color color,
      {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        Text(value,
            style: TextStyle(
                color: color,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }

  // Painel da Direita (Gráficos e Detalhes)
  Widget _buildRightPanel() {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Text('Filtrar'),
                        const Spacer(),
                        IconButton(
                            icon: const Icon(Icons.bar_chart),
                            onPressed: () {}),
                        IconButton(
                            icon: const Icon(Icons.fullscreen),
                            onPressed: () {}),
                        IconButton(
                            icon: const Icon(Icons.print), onPressed: () {}),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Gráficos
                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.end, // Alinha os gráficos na base
                    children: [
                      // Gráfico de Despesas
                      Expanded(
                        child: Column(
                          children: [
                            const Text('Despesas'),
                            SizedBox(
                              height: 200,
                              child: BarChart(BarChartData(
                                // CORRIGIDO: Adicionando dados de exemplo para o gráfico de despesas
                                barGroups: [
                                  BarChartGroupData(x: 0, barRods: [
                                    BarChartRodData(
                                        toY: 100,
                                        width: 25,
                                        color: Colors.blue[300],
                                        borderRadius: BorderRadius.zero)
                                  ]),
                                  BarChartGroupData(x: 1, barRods: [
                                    BarChartRodData(
                                        toY: 10,
                                        width: 25,
                                        color: Colors.green[300],
                                        borderRadius: BorderRadius.zero)
                                  ]),
                                  BarChartGroupData(x: 2, barRods: [
                                    BarChartRodData(
                                        toY: 5,
                                        width: 25,
                                        color: Colors.yellow[300],
                                        borderRadius: BorderRadius.zero)
                                  ]),
                                  BarChartGroupData(x: 3, barRods: [
                                    BarChartRodData(
                                        toY: 2,
                                        width: 25,
                                        color: Colors.red[300],
                                        borderRadius: BorderRadius.zero)
                                  ]),
                                ],
                                borderData: FlBorderData(show: false),
                                gridData: const FlGridData(show: false),
                                titlesData: const FlTitlesData(
                                  leftTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  rightTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  topTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  bottomTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                      // Gráfico de Receitas
                      Expanded(
                        child: Column(
                          children: [
                            const Text('Receitas'),
                            SizedBox(
                              height: 200,
                              child: BarChart(BarChartData(
                                barGroups: [
                                  BarChartGroupData(x: 0, barRods: [
                                    BarChartRodData(
                                        toY: 100,
                                        width: 50,
                                        color: Colors.blue[300],
                                        borderRadius: BorderRadius.zero)
                                  ])
                                ],
                                borderData: FlBorderData(show: false),
                                gridData: const FlGridData(show: false),
                                titlesData: const FlTitlesData(
                                  leftTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  rightTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  topTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  bottomTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  // Listas de Categorias
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Lista de Despesas
                        Expanded(
                            child: _buildCategoryList(title: '', items: {
                          'Automóvel': '-R\$ 12.313.311,23',
                          'Familiares Diversas': '-R\$ 1.321,32',
                          'Telefonia': '-R\$ 100,00',
                          'Empregados': '-R\$ 23,44',
                        }, colors: [
                          Colors.blue,
                          Colors.green,
                          Colors.yellow,
                          Colors.red
                        ], percentages: [
                          '99,99%',
                          '0,01%',
                          '0,00%',
                          '0,00%'
                        ])),
                        // Lista de Receitas
                        Expanded(
                            child: _buildCategoryList(
                                title: 'Total de receitas',
                                items: {
                                  'Outras Receitas': 'R\$ 9.910.210.422,64',
                                  'Investimentos': 'R\$ 1.231,32',
                                  'Aluguel': 'R\$ 1.000,00',
                                },
                                colors: [
                                  Colors.blue,
                                  Colors.green,
                                  Colors.yellow
                                ],
                                percentages: ['100,00%', '0,00%', '0,00%'],
                                total: 'R\$ 9.910.212.653,96')),
                      ],
                    ),
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

  Widget _buildCategoryList({
    required String title,
    required Map<String, String> items,
    required List<Color> colors,
    required List<String> percentages,
    String? total,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ...List.generate(items.length, (index) {
          final key = items.keys.elementAt(index);
          final value = items.values.elementAt(index);
          return ListTile(
            leading: Icon(Icons.circle, color: colors[index], size: 12),
            title: Text('$key ${percentages[index]}'),
            trailing: Text(value,
                style: TextStyle(
                    color: value.startsWith('-') ? Colors.red : Colors.green)),
            contentPadding: EdgeInsets.zero,
            dense: true,
          );
        }),
        if (total != null) ...[
          const Divider(),
          ListTile(
            title: const Text('Total',
                style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: Text(total,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.green)),
            contentPadding: EdgeInsets.zero,
            dense: true,
          )
        ]
      ],
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
