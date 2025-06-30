// lib/modals/editar_categoria_modal.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_financeiro_pessoal/services/category_service.dart';

class EditarCategoriaModal extends ConsumerStatefulWidget {
  final String initialName;
  final String categoryType;

  const EditarCategoriaModal({
    super.key,
    required this.initialName,
    required this.categoryType,
  });

  @override
  ConsumerState<EditarCategoriaModal> createState() =>
      _EditarCategoriaModalState();
}

class _EditarCategoriaModalState extends ConsumerState<EditarCategoriaModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (_formKey.currentState!.validate()) {
      final notifier = ref.read(categoryProvider.notifier);
      final newName = _nameController.text;

      // CORRIGIDO: Chama o método genérico que existe no serviço
      await notifier.updateCategoria(widget.initialName, newName);

      if (mounted) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar categoria',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
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
                const SizedBox(height: 16),
                DropdownButtonFormField<String?>(
                  decoration:
                      const InputDecoration(labelText: 'Subcategoria de'),
                  hint: const Text(''),
                  items: const [],
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar')),
        ElevatedButton(
          onPressed: _salvar,
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00BFA5),
              foregroundColor: Colors.white),
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
