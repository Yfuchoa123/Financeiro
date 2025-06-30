// lib/modals/nova_categoria_modal.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_financeiro_pessoal/services/category_service.dart';

class NovaCategoriaModal extends ConsumerStatefulWidget {
  final String? parentName;

  const NovaCategoriaModal({super.key, this.parentName});

  @override
  ConsumerState<NovaCategoriaModal> createState() => _NovaCategoriaModalState();
}

class _NovaCategoriaModalState extends ConsumerState<NovaCategoriaModal> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _tipoCategoria = 'Despesa';
  String? _selectedParent;

  @override
  void initState() {
    super.initState();
    _selectedParent = widget.parentName;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _salvarDados() async {
    if (!_formKey.currentState!.validate()) return;

    final notifier = ref.read(categoryProvider.notifier);
    final name = _nameController.text;

    await notifier.addCategoria(name, _tipoCategoria.toLowerCase(),
        parentName: _selectedParent);
  }

  @override
  Widget build(BuildContext context) {
    final allCategories = ref.watch(categoryProvider);

    return AlertDialog(
      title: const Text('Nova categoria',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: allCategories.when(
                data: (data) {
                  final parentOptions = _tipoCategoria == 'Despesa'
                      ? data.despesas
                      : data.receitas;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButtonFormField<String>(
                        value: _tipoCategoria,
                        decoration: const InputDecoration(labelText: 'Tipo'),
                        items: ['Despesa', 'Receita']
                            .map((String value) => DropdownMenuItem<String>(
                                value: value, child: Text(value)))
                            .toList(),
                        onChanged: (newValue) =>
                            setState(() => _tipoCategoria = newValue!),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Nome *'),
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'Campo obrigatório'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String?>(
                        value: _selectedParent,
                        decoration:
                            const InputDecoration(labelText: 'Subcategoria de'),
                        hint: const Text('Nenhuma'),
                        items: [
                          const DropdownMenuItem<String?>(
                              value: null, child: Text('Nenhuma')),
                          // CORRIGIDO: Removido o .toList() desnecessário
                          ...parentOptions
                              .where((cat) => cat.parentName == null)
                              .map((cat) => DropdownMenuItem(
                                  value: cat.name, child: Text(cat.name)))
                        ],
                        onChanged: (value) =>
                            setState(() => _selectedParent = value),
                      ),
                    ],
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (e, s) => const Text('Erro ao carregar categorias'),
              )),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            // CORRIGIDO: Lógica de 'salvar e fechar' com a verificação de segurança
            await _salvarDados();
            // ignore: use_build_context_synchronously
            if (mounted) Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00BFA5),
              foregroundColor: Colors.white),
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
