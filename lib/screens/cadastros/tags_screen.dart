// lib/screens/cadastros/tags_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_financeiro_pessoal/modals/editar_tag_modal.dart';
import 'package:meu_financeiro_pessoal/modals/nova_tag_modal.dart';
import 'package:meu_financeiro_pessoal/services/tag_service.dart';
import 'package:meu_financeiro_pessoal/models/tag_model.dart';
import 'package:meu_financeiro_pessoal/widgets/custom_app_bar.dart';

class TagsScreen extends ConsumerStatefulWidget {
  const TagsScreen({super.key});

  @override
  ConsumerState<TagsScreen> createState() => _TagsScreenState();
}

class _TagsScreenState extends ConsumerState<TagsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';
  bool _exibirApenasAtivas = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchTerm = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tagsAsyncValue = ref.watch(tagProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Tags'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 24.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      labelText: 'Buscar tags',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Text('Exibir apenas tags ativas'),
                Switch(
                  value: _exibirApenasAtivas,
                  onChanged: (val) => setState(() => _exibirApenasAtivas = val),
                ),
                const SizedBox(width: 16),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 20)),
                  child: const Text('Exportar tags ativas'),
                )
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: tagsAsyncValue.when(
                data: (tags) {
                  final filteredTags = tags.where((tag) {
                    final searchMatch = tag.name
                        .toLowerCase()
                        .contains(_searchTerm.toLowerCase());
                    final activeMatch = !_exibirApenasAtivas || tag.isActive;
                    return searchMatch && activeMatch;
                  }).toList();

                  if (filteredTags.isEmpty) {
                    return Center(/* ... empty state ... */);
                  }
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      spacing: 16.0,
                      runSpacing: 16.0,
                      children: filteredTags
                          .map((tag) => _TagChip(tag: tag))
                          .toList(),
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) =>
                    Center(child: Text('Erro ao carregar tags: $err')),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
            context: context, builder: (context) => const NovaTagModal()),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// WIDGET DO CHIP CORRIGIDO COM O MENU
class _TagChip extends ConsumerWidget {
  final Tag tag;
  const _TagChip({required this.tag});

  void _onActionSelected(BuildContext context, WidgetRef ref, String action) {
    switch (action) {
      case 'editar':
        showDialog(
            context: context, builder: (ctx) => EditarTagModal(tag: tag));
        break;
      case 'inativar':
        ref.read(tagProvider.notifier).toggleStatus(tag);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Tag atualizada.')));
        break;
      case 'excluir':
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text('Excluir Teste'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                          'Os lançamentos associados serão desassociados. Confirma a exclusão?'),
                      const SizedBox(height: 16),
                      TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Informe sua senha *')),
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('Cancelar')),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(tagProvider.notifier).deleteTag(tag.name);
                        Navigator.of(ctx).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[400]),
                      child: const Text('Excluir'),
                    )
                  ],
                ));
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusText = tag.isActive ? '' : ' (inativa)';

    return Container(
      padding: const EdgeInsets.only(left: 12.0),
      decoration: BoxDecoration(
        color: tag.color,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(tag.name + statusText,
              style: const TextStyle(color: Colors.white)),
          const SizedBox(width: 4),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white, size: 18),
            onSelected: (value) => _onActionSelected(context, ref, value),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'editar', child: Text('Editar')),
              PopupMenuItem(
                  value: 'inativar',
                  child: Text(tag.isActive ? 'Inativar' : 'Ativar')),
              const PopupMenuItem(value: 'excluir', child: Text('Excluir')),
            ],
          ),
        ],
      ),
    );
  }
}
