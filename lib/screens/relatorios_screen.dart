// lib/screens/relatorios_screen.dart

import 'package:flutter/material.dart';
import 'package:meu_financeiro_pessoal/screens/reports/evolucao_por_categoria_report.dart'; // <-- IMPORT ADICIONADO
import 'package:meu_financeiro_pessoal/screens/reports/totais_por_categoria_report.dart';
import 'package:meu_financeiro_pessoal/screens/reports/totais_por_centro_report.dart';
import 'package:meu_financeiro_pessoal/screens/reports/totais_por_contato_report.dart';
import 'package:meu_financeiro_pessoal/screens/reports/totais_por_projeto_report.dart';
import 'package:meu_financeiro_pessoal/widgets/custom_app_bar.dart';

class RelatoriosScreen extends StatelessWidget {
  const RelatoriosScreen({super.key});

  final List<String> receitasDespesasTitles = const [
    'Totais por categoria',
    'Lançamentos por categoria',
    'Totais por centro',
    'Lançamentos por centro',
    'Totais por contato',
    'Lançamentos por contato',
    'Totais por projeto',
    'Lançamentos por projeto',
    'Evolução por categoria',
    'Evolução por centro',
    'Evolução por contato',
    'Evolução das metas de categorias',
    'Evolução das metas de centros',
    'Resultado dos projetos',
    'Resultados entre períodos',
  ];

  final List<String> caixaTitles = const [
    'Fluxo de caixa',
    'Lançamentos de caixa',
    'Contas a pagar',
    'Contas a receber',
    'Contas pagas',
    'Contas recebidas',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = (screenWidth / 2) - 40;

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Relatórios'),
      //   backgroundColor: const Color(0xFF00BFA5),
      //   foregroundColor: Colors.white,
      // ),
      // ADICIONE ISTO NO LUGAR:
      appBar: const CustomAppBar(title: 'Relatórios'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Receitas e despesas',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              children: receitasDespesasTitles
                  .map((title) =>
                      _buildReportButton(context, title, buttonWidth))
                  .toList(),
            ),
            const SizedBox(height: 40),
            Text(
              'Caixa',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              children: caixaTitles
                  .map((title) =>
                      _buildReportButton(context, title, buttonWidth))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportButton(BuildContext context, String title, double width) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: () {
          // Lógica de navegação ATUALIZADA
          Widget? page;
          if (title == 'Totais por categoria') {
            page = const TotaisPorCategoriaReport();
          } else if (title == 'Totais por centro') {
            page = const TotaisPorCentroReport();
          } else if (title == 'Totais por contato') {
            page = const TotaisPorContatoReport();
          } else if (title == 'Totais por projeto') {
            page = const TotaisPorProjetoReport();
          } else if (title == 'Evolução por categoria') {
            page = const EvolucaoPorCategoriaReport();
          }

          if (page != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page!),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          // ignore: deprecated_member_use
          shadowColor: Colors.grey.withAlpha(51),
        ),
        child: Text(title),
      ),
    );
  }
}
