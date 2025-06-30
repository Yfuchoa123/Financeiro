// lib/screens/reports/evolucao_por_categoria_report.dart

import 'package:flutter/material.dart';
import 'package:meu_financeiro_pessoal/widgets/custom_app_bar.dart';

class EvolucaoPorCategoriaReport extends StatelessWidget {
  const EvolucaoPorCategoriaReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Relatórios / Evolução por categoria'),
      //   backgroundColor: const Color(0xFF00BFA5),
      //   foregroundColor: Colors.white,
      //   elevation: 0,
      // ),
      // ADICIONE ISTO NO LUGAR:
      appBar: const CustomAppBar(title: 'Relatórios / Evolução por categoria'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTopFilterBar(), // Este método foi alterado
            const SizedBox(height: 16),
            Expanded(
              child: Card(
                elevation: 2,
                clipBehavior: Clip.antiAlias,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: _buildDataTable(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // MÉTODO ATUALIZADO PARA O ESTILO COM CAMPOS DE SELEÇÃO
  Widget _buildTopFilterBar() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            // Usando um helper para criar os campos com aparência de input
            _buildFilterField('Intervalo', 'Mensal'),
            const SizedBox(width: 16),
            _buildFilterField('Início', 'janeiro 2025'),
            const SizedBox(width: 16),
            _buildFilterField('Período', '6 meses'),
            const SizedBox(width: 24),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.pink,
                side: const BorderSide(color: Colors.pink),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              ),
              child: const Text('Carregar'),
            ),
            const Spacer(),
            const Text('Filtrar'),
            IconButton(
                icon: const Icon(Icons.cancel_outlined), onPressed: () {}),
            IconButton(icon: const Icon(Icons.bar_chart), onPressed: () {}),
            IconButton(
                icon: const Icon(Icons.arrow_downward), onPressed: () {}),
            IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
            IconButton(icon: const Icon(Icons.print), onPressed: () {}),
          ],
        ),
      ),
    );
  }

  // Helper para criar os campos de filtro com borda
  Widget _buildFilterField(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text('$label: '),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_drop_down, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildDataTable() {
    const headerStyle = TextStyle(fontWeight: FontWeight.bold);

    return DataTable(
      headingRowColor: WidgetStateProperty.all(Colors.grey[100]),
      dataRowMinHeight: 60.0,
      dataRowMaxHeight: 70.0,
      columns: const [
        DataColumn(label: Text('')),
        DataColumn(label: Text('Jan/25', style: headerStyle), numeric: true),
        DataColumn(label: Text('Fev/25', style: headerStyle), numeric: true),
        DataColumn(label: Text('Mar/25', style: headerStyle), numeric: true),
        DataColumn(label: Text('Abr/25', style: headerStyle), numeric: true),
        DataColumn(label: Text('Mai/25', style: headerStyle), numeric: true),
        DataColumn(label: Text('Jun/25', style: headerStyle), numeric: true),
        DataColumn(label: Text('Média', style: headerStyle), numeric: true),
        DataColumn(label: Text('Total', style: headerStyle), numeric: true),
      ],
      rows: [
        _buildDataRow('Receitas',
            isHeader: true,
            color: Colors.green[50],
            values: [
              '0,00',
              '0,00',
              '0,00',
              '0,00',
              '0,00',
              '9.910.212.653,96',
              '1.651.702.108,99',
              '9.910.212.653,96'
            ]),
        _buildDataRow('Aluguel', isSubRow: true, values: [
          '0,00',
          '0,00',
          '0,00',
          '0,00',
          '0,00',
          '1.000,00',
          '166,67',
          '1.000,00'
        ]),
        _buildDataRow('Investimentos', isSubRow: true, values: [
          '0,00',
          '0,00',
          '0,00',
          '0,00',
          '0,00',
          '1.231,32',
          '205,22',
          '1.231,32'
        ]),
        _buildDataRow('Outras Receitas', isSubRow: true, values: [
          '0,00',
          '0,00',
          '0,00',
          '0,00',
          '0,00',
          '9.910.210.422,64',
          '1.651.701.737,11',
          '9.910.210.422,64'
        ]),
        _buildDataRow('Despesas',
            isHeader: true,
            color: Colors.red[50],
            values: [
              '0,00',
              '0,00',
              '0,00',
              '0,00',
              '0,00',
              '-12.314.755,99',
              '-2.052.459,33',
              '-12.314.755,99'
            ],
            percentages: [
              '',
              '',
              '',
              '',
              '',
              '0,12%',
              '0,12%',
              '0,12%'
            ]),
        _buildDataRow('Automóvel', isSubRow: true, values: [
          '0,00',
          '0,00',
          '0,00',
          '0,00',
          '0,00',
          '-12.313.311,23',
          '-2.052.218,54',
          '-12.313.311,23'
        ], percentages: [
          '-',
          '-',
          '-',
          '-',
          '-',
          '0,12%',
          '0,12%',
          '0,12%'
        ]),
        _buildDataRow('Empregados', isSubRow: true, values: [
          '0,00',
          '0,00',
          '0,00',
          '0,00',
          '0,00',
          '-23,44',
          '-3,91',
          '-23,44'
        ], percentages: [
          '-',
          '-',
          '-',
          '-',
          '-',
          '0,00%',
          '0,00%',
          '0,00%'
        ]),
        _buildDataRow('Familiares Diversas', isSubRow: true, values: [
          '0,00',
          '0,00',
          '0,00',
          '0,00',
          '0,00',
          '-1.321,32',
          '-220,22',
          '-1.321,32'
        ], percentages: [
          '-',
          '-',
          '-',
          '-',
          '-',
          '0,00%',
          '0,00%',
          '0,00%'
        ]),
        _buildDataRow('Telefonia', isSubRow: true, values: [
          '0,00',
          '0,00',
          '0,00',
          '0,00',
          '0,00',
          '-100,00',
          '-16,67',
          '-100,00'
        ], percentages: [
          '-',
          '-',
          '-',
          '-',
          '-',
          '0,00%',
          '0,00%',
          '0,00%'
        ]),
        _buildDataRow('Resultado', isHeader: true, values: [
          '0,00',
          '0,00',
          '0,00',
          '0,00',
          '0,00',
          '9.897.897.897,97',
          '1.649.649.649,66',
          '9.897.897.897,97'
        ]),
      ],
    );
  }

  DataRow _buildDataRow(String title,
      {bool isHeader = false,
      bool isSubRow = false,
      Color? color,
      required List<String> values,
      List<String>? percentages}) {
    final style =
        TextStyle(fontWeight: isHeader ? FontWeight.bold : FontWeight.normal);

    return DataRow(
      color: WidgetStateProperty.all(color),
      cells: [
        DataCell(
          Padding(
            padding: EdgeInsets.only(left: isSubRow ? 16.0 : 0),
            child: Text(title, style: style),
          ),
        ),
        ...List.generate(values.length, (index) {
          final percentage = (percentages != null && percentages.length > index)
              ? percentages[index]
              : null;
          return DataCell(
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(values[index], style: style),
                if (percentage != null)
                  Text(percentage,
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          );
        }),
      ],
    );
  }
}
