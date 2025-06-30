// lib/modals/nova_conta_modal.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_financeiro_pessoal/services/conta_service.dart';
import 'package:meu_financeiro_pessoal/utils/currency_input_formatter.dart';

class NovaContaModal extends ConsumerStatefulWidget {
  const NovaContaModal({super.key});

  @override
  ConsumerState<NovaContaModal> createState() => _NovaContaModalState();
}

class _NovaContaModalState extends ConsumerState<NovaContaModal> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _balanceController = TextEditingController();
  String _type = 'corrente';

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

      await notifier.addConta(_nameController.text, _type,
          initialBalance: balance);

      if (mounted) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nova Conta'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: _type,
                  decoration: const InputDecoration(labelText: 'Tipo de Conta'),
                  items: const [
                    DropdownMenuItem(
                        value: 'corrente', child: Text('Conta Corrente')),
                    DropdownMenuItem(
                        value: 'cartao', child: Text('Cartão de Crédito')),
                  ],
                  onChanged: (val) => setState(() => _type = val!),
                ),
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
