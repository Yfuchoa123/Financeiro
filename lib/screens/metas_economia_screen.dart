// lib/screens/metas_economia_screen.dart

import 'package:flutter/material.dart';
import 'package:meu_financeiro_pessoal/widgets/meta_economia_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:meu_financeiro_pessoal/widgets/custom_app_bar.dart';

class MetasEconomiaScreen extends StatelessWidget {
  const MetasEconomiaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Metas de economia'),
      //   backgroundColor: const Color(0xFF00BFA5),
      //   foregroundColor: Colors.white,
      // ),
      // ADICIONE ISTO NO LUGAR:
      appBar: const CustomAppBar(title: 'Metas de economia'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Wrap(
          spacing: 24.0, // Espaço horizontal entre os cards
          runSpacing: 24.0, // Espaço vertical entre os cards
          children: [
            // Card 1
            MetaEconomiaCard(
              title: 'Evento Nadsda',
              objetivo: 'R\$ 213.123,00',
              prazo: 'até junho de 2026',
              saldo: 'R\$ 876,56',
              saldoContaCorrente: 'R\$ 876,56',
              aRealizar: 'R\$ 212.246,44',
              aplicacaoIdeal: 'R\$ 18.805,81',
              chartSections: [
                PieChartSectionData(
                  color: Colors.grey[300],
                  value: 99.6,
                  title: '99,6%',
                  radius: 20,
                  titleStyle: const TextStyle(color: Colors.black54),
                ),
                PieChartSectionData(
                  color: Colors.blue,
                  value: 0.4,
                  title: '',
                  radius: 20,
                ),
              ],
            ),
            // Card 2
            MetaEconomiaCard(
              title: 'dsdsda',
              objetivo: 'R\$ 232,13',
              prazo: 'até junho de 2026',
              saldo: 'R\$ 121,23',
              saldoContaCorrente: 'R\$ 121,23',
              aRealizar: 'R\$ 110,90',
              aplicacaoIdeal: 'R\$ 8,16',
              chartSections: [
                PieChartSectionData(
                  color: Colors.grey[300],
                  value: 47.8,
                  title: '47,8%',
                  radius: 20,
                  titleStyle: const TextStyle(color: Colors.black54),
                ),
                PieChartSectionData(
                  color: Colors.blue,
                  value: 52.2,
                  title: '52,2%',
                  radius: 20,
                  titleStyle: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFE91E63),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
