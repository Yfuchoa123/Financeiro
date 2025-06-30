// lib/modals/nova_despesa_modal.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_financeiro_pessoal/models/lancamento_model.dart';
import 'package:meu_financeiro_pessoal/services/lancamento_service.dart';
import 'package:meu_financeiro_pessoal/utils/currency_input_formatter.dart';

class NovaDespesaModal extends ConsumerStatefulWidget {
  const NovaDespesaModal({super.key});

  @override
  ConsumerState<NovaDespesaModal> createState() => _NovaDespesaModalState();
}

class _NovaDespesaModalState extends ConsumerState<NovaDespesaModal> {
  final _formKey = GlobalKey<FormState>();
  final _valorController = TextEditingController();
  final _descricaoController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _valorController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  void _salvar() async {
    if (_formKey.currentState!.validate()) {
      final valueString = _valorController.text
          .replaceAll(RegExp(r'[R$\s.]'), '')
          .replaceAll(',', '.');
      final value = double.tryParse(valueString) ?? 0.0;

      final novoLancamento = Lancamento(
        description: _descricaoController.text,
        type: 'despesa',
        value: -value, // Despesa tem valor negativo
        date: _selectedDate,
        accountId: 1, // Exemplo: ID da conta
        categoryName: 'Automóvel', // Exemplo: Categoria
      );

      await ref.read(lancamentoProvider.notifier).addLancamento(novoLancamento);

      if (mounted) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nova Despesa'),
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _valorController,
                  decoration: const InputDecoration(labelText: 'Valor (R\$) *'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter()],
                  validator: (val) =>
                      (val == null || val.isEmpty) ? 'Campo obrigatório' : null,
                ),
                TextFormField(
                  controller: _descricaoController,
                  decoration: const InputDecoration(labelText: 'Descrição *'),
                  validator: (val) =>
                      (val == null || val.isEmpty) ? 'Campo obrigatório' : null,
                ),
                // Adicione os outros campos aqui (Data, Conta, Categoria, etc.)
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar')),
        ElevatedButton(onPressed: _salvar, child: const Text('Salvar')),
      ],
    );
  }
}
