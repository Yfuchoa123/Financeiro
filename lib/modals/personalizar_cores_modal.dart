// lib/modals/personalizar_cores_modal.dart

import 'package:flutter/material.dart';

class PersonalizarCoresModal extends StatefulWidget {
  const PersonalizarCoresModal({super.key});

  @override
  State<PersonalizarCoresModal> createState() => _PersonalizarCoresModalState();
}

class _PersonalizarCoresModalState extends State<PersonalizarCoresModal> {
  // Guarda qual item está sendo editado no momento
  String _editingItem = 'Negativo';

  // Guarda as cores selecionadas para cada item
  final Map<String, Color> _selectedColors = {
    'Negativo': Colors.red[400]!,
    'Positivo': Colors.green[400]!,
    'Variação (investimentos)': Colors.green[400]!,
    'Pendentes': Colors.pink[200]!,
    'Confirmados': Colors.lightGreen[300]!,
    'Conciliados': Colors.purple[200]!,
    'Agendados': Colors.blue[200]!,
    'Lançamentos (modo diurno)': Colors.grey[800]!,
    'Lançamentos (modo noturno)': Colors.white,
  };

  // Paleta de cores para o seletor
  final List<Color> _colorPalette = [
    Colors.red[100]!,
    Colors.pink[100]!,
    Colors.purple[100]!,
    Colors.deepPurple[100]!,
    Colors.indigo[100]!,
    Colors.blue[100]!,
    Colors.lightBlue[100]!,
    Colors.cyan[100]!,
    Colors.teal[100]!,
    Colors.green[100]!,
    Colors.lightGreen[100]!,
    Colors.lime[100]!,
    Colors.red[300]!,
    Colors.pink[300]!,
    Colors.purple[300]!,
    Colors.deepPurple[300]!,
    Colors.indigo[300]!,
    Colors.blue[300]!,
    Colors.lightBlue[300]!,
    Colors.cyan[300]!,
    Colors.teal[300]!,
    Colors.green[300]!,
    Colors.lightGreen[300]!,
    Colors.lime[300]!,
    Colors.red[700]!,
    Colors.pink[700]!,
    Colors.purple[700]!,
    Colors.deepPurple[700]!,
    Colors.indigo[700]!,
    Colors.blue[700]!,
    Colors.lightBlue[700]!,
    Colors.cyan[700]!,
    Colors.teal[700]!,
    Colors.green[700]!,
    Colors.lightGreen[700]!,
    Colors.lime[700]!,
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: const EdgeInsets.all(24.0),
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            // Cabeçalho
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Personalizar esquema de cores',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop()),
              ],
            ),
            const Divider(height: 32),
            // Corpo Principal
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Coluna de Opções
                  Expanded(
                    flex: 2,
                    child: ListView(
                      children: [
                        const Text('Cor de valores',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        _buildColorOption('Negativo'),
                        _buildColorOption('Positivo'),
                        _buildColorOption('Variação (investimentos)'),
                        const SizedBox(height: 24),
                        const Text('Cor dos status dos lançamentos',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        _buildColorOption('Pendentes'),
                        _buildColorOption('Confirmados'),
                        _buildColorOption('Conciliados'),
                        _buildColorOption('Agendados'),
                        const SizedBox(height: 24),
                        const Text('Cor da descrição',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        _buildColorOption('Lançamentos (modo diurno)'),
                        _buildColorOption('Lançamentos (modo noturno)'),
                      ],
                    ),
                  ),
                  const VerticalDivider(width: 32),
                  // Coluna do Seletor de Cor
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Escolher cor para',
                            style: TextStyle(color: Colors.grey[600])),
                        Text(_editingItem,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _selectedColors[_editingItem],
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child: GridView.builder(
                            itemCount: _colorPalette.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 12,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                            ),
                            itemBuilder: (context, index) {
                              final color = _colorPalette[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedColors[_editingItem] = color;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: color,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 32),
            // Rodapé
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BFA5),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16)),
                child: const Text('Salvar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorOption(String title) {
    bool isSelected = _editingItem == title;
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.circle, color: _selectedColors[title]),
      onTap: () {
        setState(() {
          _editingItem = title;
        });
      },
      selected: isSelected,
      selectedTileColor: Colors.grey[200],
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}
