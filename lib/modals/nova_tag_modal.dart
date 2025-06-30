// lib/modals/nova_tag_modal.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_financeiro_pessoal/services/tag_service.dart';

class NovaTagModal extends ConsumerStatefulWidget {
  const NovaTagModal({super.key});

  @override
  ConsumerState<NovaTagModal> createState() => _NovaTagModalState();
}

class _NovaTagModalState extends ConsumerState<NovaTagModal> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  Color _selectedColor = Colors.red.shade400;

  // Paleta de cores
  final List<Color> _colorPalette = [
    Colors.red[400]!,
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
    Colors.lime[400]!,
    Colors.yellow[600]!,
    Colors.amber[600]!,
    Colors.orange[600]!,
    Colors.deepOrange[400]!,
    Colors.brown[400]!,
    Colors.grey[500]!,
    Colors.blueGrey[400]!,
    Colors.black,
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (_formKey.currentState!.validate()) {
      await ref
          .read(tagProvider.notifier)
          .addTag(_nameController.text, _selectedColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nova tag'),
      scrollable: true,
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome *'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              // Seletor de Cores
              Row(
                children: [
                  const Text('Cor:'),
                  const Spacer(),
                  Container(width: 100, height: 30, color: _selectedColor),
                  const SizedBox(width: 8),
                  Container(width: 30, height: 30, color: _selectedColor),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 150,
                child: GridView.builder(
                  itemCount: _colorPalette.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                  ),
                  itemBuilder: (context, index) {
                    final color = _colorPalette[index];
                    return GestureDetector(
                      onTap: () => setState(() => _selectedColor = color),
                      child: Container(
                        decoration: BoxDecoration(
                          color: color,
                          border: _selectedColor == color
                              ? Border.all(color: Colors.blueAccent, width: 3)
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar')),
        ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await _salvar();
                // ignore: use_build_context_synchronously
                if (mounted) Navigator.of(context).pop();
              }
            },
            child: const Text('Salvar'))
      ],
    );
  }
}
