// lib/modals/editar_tag_modal.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_financeiro_pessoal/models/tag_model.dart';
import 'package:meu_financeiro_pessoal/services/tag_service.dart';

class EditarTagModal extends ConsumerStatefulWidget {
  final Tag tag;
  const EditarTagModal({super.key, required this.tag});

  @override
  ConsumerState<EditarTagModal> createState() => _EditarTagModalState();
}

class _EditarTagModalState extends ConsumerState<EditarTagModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late Color _selectedColor;

  final List<Color> _colorPalette = [/* ... Sua paleta de cores ... */];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.tag.name);
    _selectedColor = widget.tag.color;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(tagProvider.notifier).updateTag(
            widget.tag.name,
            _nameController.text,
            _selectedColor,
          );
      if (mounted) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar tag'),
      content: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nome *'),
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Campo obrigatório'
                      : null,
                ),
                const SizedBox(height: 24),
                // Seletor de Cores (código omitido por brevidade, pode colar o que já tinha)
              ],
            ),
          ))),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar')),
        ElevatedButton(onPressed: _salvar, child: const Text('Salvar'))
      ],
    );
  }
}
