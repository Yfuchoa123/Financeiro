// lib/screens/regras_preenchimento_screen.dart

import 'package:flutter/material.dart';
import 'package:meu_financeiro_pessoal/modals/nova_regra_modal.dart';
import 'package:meu_financeiro_pessoal/widgets/custom_app_bar.dart';

class RegrasPreenchimentoScreen extends StatefulWidget {
  const RegrasPreenchimentoScreen({super.key});

  @override
  State<RegrasPreenchimentoScreen> createState() =>
      _RegrasPreenchimentoScreenState();
}

class _RegrasPreenchimentoScreenState extends State<RegrasPreenchimentoScreen> {
  String _selectedType = 'Despesa';

  // Dados de exemplo
  final Map<String, List<Map<String, dynamic>>> _regras = {
    'Despesa': [
      {
        'title': 'dsdsda (www.Aliexpress.com)',
        'tags': ['Yuri Yuri', 'Impostos e Tarifas', 'Yuri Forte']
      }
    ],
    'Receita': [],
    'Transferência': [],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Regras de preenchimento'),
      //   backgroundColor: const Color(0xFF00BFA5),
      //   foregroundColor: Colors.white,
      // ),
      // ADICIONE ISTO NO LUGAR:
      appBar: const CustomAppBar(title: 'Regras de preenchimento'),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLeftPanel(),
          _buildRightPanel(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context, builder: (context) => const NovaRegraModal());
        },
        backgroundColor: const Color(0xFFE91E63),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildLeftPanel() {
    return SizedBox(
      width: 350,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Card(
              elevation: 2,
              child: Column(
                children: [
                  _buildFilterItem(Icons.arrow_downward, 'Despesa',
                      _regras['Despesa']!.length),
                  const Divider(height: 1),
                  _buildFilterItem(Icons.arrow_upward, 'Receita',
                      _regras['Receita']!.length),
                  const Divider(height: 1),
                  _buildFilterItem(Icons.compare_arrows, 'Transferência',
                      _regras['Transferência']!.length),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Buscar regras',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterItem(IconData icon, String title, int count) {
    final bool isSelected = _selectedType == title;
    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.teal : Colors.grey),
      title: Text(title,
          style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      trailing: Text('($count)'),
      onTap: () => setState(() => _selectedType = title),
      selected: isSelected,
      // ignore: deprecated_member_use
      selectedTileColor: Colors.teal.withAlpha(26),
    );
  }

  Widget _buildRightPanel() {
    final currentRules = _regras[_selectedType]!;

    if (currentRules.isEmpty) {
      return _buildEmptyState();
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 24, 24, 24),
        child: ListView.builder(
          itemCount: currentRules.length,
          itemBuilder: (context, index) {
            final rule = currentRules[index];
            return Card(
              elevation: 2,
              child: ListTile(
                leading: const Checkbox(value: false, onChanged: null),
                title: Text(rule['title'],
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Wrap(
                  spacing: 8.0,
                  children: (rule['tags'] as List<String>)
                      .map((tag) => Chip(
                            label:
                                Text(tag, style: const TextStyle(fontSize: 12)),
                            visualDensity: VisualDensity.compact,
                          ))
                      .toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
                'Não há regras de preenchimento cadastradas para ${_selectedType.toLowerCase()}.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            const Text(
                'Elas facilitam o preenchimento de informações nos seus lançamentos.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => const NovaRegraModal());
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00BFA5),
                  foregroundColor: Colors.white),
              child: const Text('Criar regra de preenchimento'),
            )
          ],
        ),
      ),
    );
  }
}
