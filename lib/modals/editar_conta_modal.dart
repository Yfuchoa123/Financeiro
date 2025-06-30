// lib/modals/editar_conta_modal.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_financeiro_pessoal/models/conta_model.dart';
import 'package:meu_financeiro_pessoal/services/conta_service.dart';
import 'package:meu_financeiro_pessoal/utils/currency_input_formatter.dart';

class EditarContaModal extends ConsumerStatefulWidget {
  final Conta conta;
  const EditarContaModal({super.key, required this.conta});

  @override
  ConsumerState<EditarContaModal> createState() => _EditarContaModalState();
}

class _EditarContaModalState extends ConsumerState<EditarContaModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _balanceController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.conta.name);
    _balanceController = TextEditingController(
        text: widget.conta.initialBalance
            .toStringAsFixed(2)
            .replaceAll('.', ','));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  void _salvar() async {
    if (_formKey.currentState!.validate()) {
      final notifier = ref.read(contaProvider.notifier);
      final valueString = _balanceController.text
          .replaceAll(RegExp(r'[R$\s.]'), '')
          .replaceAll(',', '.');
      final balance = double.tryParse(valueString) ?? 0.0;

      // Cria um novo objeto Conta com os dados atualizados
      final updatedConta = Conta(
        id: widget.conta.id,
        name: _nameController.text,
        type: widget.conta.type,
        initialBalance: balance,
        isActive: widget.conta.isActive,
      );

      await notifier.updateConta(updatedConta);

      if (mounted) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Conta'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration:
                      const InputDecoration(labelText: 'Nome da Conta *'),
                  validator: (val) => (val == null || val.isEmpty)
                      ? 'O nome é obrigatório'
                      : null,
                ),
                TextFormField(
                  controller: _balanceController,
                  decoration: const InputDecoration(labelText: 'Saldo Inicial'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter()],
                ),
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
