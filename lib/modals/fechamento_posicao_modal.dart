// lib/modals/fechamento_posicao_modal.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FechamentoPosicaoModal extends StatefulWidget {
  const FechamentoPosicaoModal({super.key});

  @override
  State<FechamentoPosicaoModal> createState() => _FechamentoPosicaoModalState();
}

class _FechamentoPosicaoModalState extends State<FechamentoPosicaoModal> {
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(text: '31/05/2025');
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2025, 5, 31),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: const EdgeInsets.all(24.0),
        width: MediaQuery.of(context).size.width * 0.35,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Fechamento de posição',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Corpo
            const Text(
              'Não serão permitidas inclusões/edições/exclusões de lançamentos financeiros ou operações de investimentos com data de confirmação igual ou anterior a data de fechamento.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Data do fechamento',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ),
              readOnly: true, // Impede a digitação manual
              onTap: () => _selectDate(context),
            ),
            const SizedBox(height: 8),
            const Text(
              '*Para não estabelecer uma data, deixe o campo em branco',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 32),
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
}
