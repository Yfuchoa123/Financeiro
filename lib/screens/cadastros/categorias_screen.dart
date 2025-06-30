// lib/screens/cadastros/categorias_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_financeiro_pessoal/models/category_model.dart';
import 'package:meu_financeiro_pessoal/services/category_service.dart';
import 'package:meu_financeiro_pessoal/modals/editar_categoria_modal.dart';
import 'package:meu_financeiro_pessoal/modals/nova_categoria_modal.dart';
import 'package:meu_financeiro_pessoal/widgets/custom_app_bar.dart';

class CategoriasScreen extends ConsumerStatefulWidget {
  const CategoriasScreen({super.key});

  @override
  ConsumerState<CategoriasScreen> createState() => _CategoriasScreenState();
}

class _CategoriasScreenState extends ConsumerState<CategoriasScreen> {
  bool _exibirApenasAtivas = false;

  void _onActionSelected(
      String action, Category category, String categoryType) {
    final notifier = ref.read(categoryProvider.notifier);
    switch (action) {
      case 'editar':
        showDialog(
          context: context,
          builder: (context) => EditarCategoriaModal(
            initialName: category.name,
            categoryType: categoryType,
          ),
        );
        break;
      case 'ativar_inativar':
        notifier.toggleStatus(category);
        break;
      case 'excluir':
        // CORRIGIDO: Passando os dois argumentos necessários
        _showDeleteConfirmation(category, categoryType);
        break;
    }
  }

  void _showDeleteConfirmation(Category category, String categoryType) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: Text(
            'Tem certeza de que deseja excluir a categoria "${category.name}"?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () async {
              final navigator = Navigator.of(ctx);
              final notifier = ref.read(categoryProvider.notifier);

              await notifier.deleteCategoria(category.name);

              navigator.pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(categoryProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Categorias'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Spacer(),
                const Text('Exibir apenas categorias ativas'),
                Switch(
                  value: _exibirApenasAtivas,
                  onChanged: (value) =>
                      setState(() => _exibirApenasAtivas = value),
                ),
                const SizedBox(width: 24),
                OutlinedButton(
                    onPressed: () {},
                    child: const Text('Exportar categorias ativas')),
              ],
            ),
          ),
          Expanded(
            child: categoryState.when(
              data: (data) {
                final despesasVisiveis = _exibirApenasAtivas
                    ? data.despesas.where((d) => d.isActive).toList()
                    : data.despesas;
                final receitasVisiveis = _exibirApenasAtivas
                    ? data.receitas.where((r) => r.isActive).toList()
                    : data.receitas;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCategoryColumn('Despesas', despesasVisiveis),
                    const VerticalDivider(width: 1),
                    _buildCategoryColumn('Receitas', receitasVisiveis),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Erro: $err')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
            context: context, builder: (context) => const NovaCategoriaModal()),
        backgroundColor: const Color(0xFFE91E63),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildCategoryColumn(String title, List<Category> items) {
    final parentCategories = items.where((c) => c.parentName == null).toList();

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54)),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: parentCategories.length,
              itemBuilder: (context, index) {
                final parent = parentCategories[index];
                final subCategories =
                    items.where((c) => c.parentName == parent.name).toList();

                return Column(
                  children: [
                    if (index != 0) const Divider(height: 1),
                    CategoriaListItem(
                      category: parent,
                      onActionSelected: (action) =>
                          _onActionSelected(action, parent, title),
                    ),
                    if (subCategories.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          children: subCategories
                              .map((sub) => Column(
                                    children: [
                                      const Divider(height: 1),
                                      CategoriaListItem(
                                        category: sub,
                                        onActionSelected: (action) =>
                                            _onActionSelected(
                                                action, sub, title),
                                      ),
                                    ],
                                  ))
                              .toList(),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategoriaListItem extends StatelessWidget {
  final Category category;
  final Function(String) onActionSelected;

  const CategoriaListItem({
    super.key,
    required this.category,
    required this.onActionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final statusText = !category.isActive ? " (inativa)" : "";
    return ListTile(
      title: Text('${category.name}$statusText'),
      trailing: PopupMenuButton<String>(
        onSelected: onActionSelected,
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
              value: 'editar',
              child:
                  ListTile(leading: Icon(Icons.edit), title: Text('Editar'))),
          if (category.parentName == null)
            const PopupMenuItem<String>(
                value: 'criar_subcategoria',
                child: ListTile(
                    leading: Icon(Icons.add),
                    title: Text('Criar subcategoria'))),
          PopupMenuItem<String>(
            value: 'ativar_inativar',
            child: ListTile(
              leading: Icon(!category.isActive
                  ? Icons.check_circle_outline
                  : Icons.power_settings_new),
              title: Text(!category.isActive ? 'Ativar' : 'Inativar'),
            ),
          ),
          const PopupMenuItem<String>(
              value: 'excluir',
              child: ListTile(
                  leading: Icon(Icons.delete), title: Text('Excluir'))),
        ],
      ),
    );
  }
}
