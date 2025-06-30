// lib/widgets/meta_economia_card.dart

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MetaEconomiaCard extends StatelessWidget {
  final String title;
  final String objetivo;
  final String prazo;
  final String saldo;
  final String saldoContaCorrente;
  final String aRealizar;
  final String aplicacaoIdeal;
  final List<PieChartSectionData> chartSections;

  const MetaEconomiaCard({
    super.key,
    required this.title,
    required this.objetivo,
    required this.prazo,
    required this.saldo,
    required this.saldoContaCorrente,
    required this.aRealizar,
    required this.aplicacaoIdeal,
    required this.chartSections,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: SizedBox(
        width: 450, // Largura fixa para cada card
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Cabeçalho
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                      icon: const Icon(Icons.more_vert), onPressed: () {}),
                ],
              ),
              const SizedBox(height: 24),
              // Gráfico Donut
              SizedBox(
                height: 150,
                width: 150,
                child: PieChart(
                  PieChartData(
                    sections: chartSections,
                    centerSpaceRadius: 50,
                    sectionsSpace: 2,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Detalhes
              _buildInfoRow('Objetivo', objetivo, subText: prazo),
              const Divider(height: 24),
              _buildInfoRow('Saldo', saldo, color: Colors.green),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                child: _buildInfoRow('Conta corrente', saldoContaCorrente,
                    isSubItem: true),
              ),
              const Divider(height: 24),
              _buildInfoRow('A realizar', aRealizar, color: Colors.green),
              const SizedBox(height: 8),
              _buildInfoRow('Aplicação mensal ideal', aplicacaoIdeal,
                  color: Colors.green),
              const SizedBox(height: 32),
              // Botão
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.pink),
                  foregroundColor: Colors.pink,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                child: const Text('Visualizar extrato'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value,
      {Color? color, String? subText, bool isSubItem = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (isSubItem)
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.circle, size: 8, color: Colors.blue),
              ),
            Text(label),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16, color: color),
            ),
            if (subText != null)
              Text(
                subText,
                style: const TextStyle(color: Colors.grey),
              ),
          ],
        )
      ],
    );
  }
}
