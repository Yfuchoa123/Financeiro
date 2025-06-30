import 'package:flutter/material.dart';

enum RepetitionType { unica, parcelada, fixa }

class DefinirRepeticaoModal extends StatefulWidget {
  const DefinirRepeticaoModal({super.key});

  @override
  State<DefinirRepeticaoModal> createState() => _DefinirRepeticaoModalState();
}

class _DefinirRepeticaoModalState extends State<DefinirRepeticaoModal> {
  RepetitionType _repetitionType =
      RepetitionType.parcelada; // Padrão 'Parcelada' da sua foto

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      title: const Text('Definir repetição'),
      content: SizedBox(
        width: screenWidth * 0.4, // Largura ajustável
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Radio Buttons para o tipo de repetição
            Row(
              children: [
                Expanded(
                  child: RadioListTile<RepetitionType>(
                    title: const Text('Única'),
                    value: RepetitionType.unica,
                    groupValue: _repetitionType,
                    onChanged: (val) {
                      setState(() {
                        _repetitionType = val!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<RepetitionType>(
                    title: const Text('Parcelada'),
                    value: RepetitionType.parcelada,
                    groupValue: _repetitionType,
                    onChanged: (val) {
                      setState(() {
                        _repetitionType = val!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<RepetitionType>(
                    title: const Text('Fixa'),
                    value: RepetitionType.fixa,
                    groupValue: _repetitionType,
                    onChanged: (val) {
                      setState(() {
                        _repetitionType = val!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // --- Campos Condicionais ---
            if (_repetitionType == RepetitionType.parcelada ||
                _repetitionType == RepetitionType.fixa)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Periodicidade*',
                          ),
                          keyboardType: TextInputType.number,
                          initialValue: '1',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Repete-se a cada n meses *',
                          ),
                          keyboardType: TextInputType.number,
                          initialValue: '1',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            if (_repetitionType == RepetitionType.parcelada)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Número de parcelas *',
                          ),
                          initialValue: '2',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Parcela inicial *',
                          ),
                          initialValue: '1',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Valor da parcela (R\$)*',
                      suffixIcon: Icon(Icons.check_box),
                    ),
                    initialValue: '13.121,32',
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            if (_repetitionType == RepetitionType.fixa)
              Row(
                children: [
                  Checkbox(value: true, onChanged: (val) {}),
                  const Text('Definir total de ocorrências'),
                ],
              ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00BFA5),
          ),
          child: const Text('Aplicar alterações'),
        ),
      ],
    );
  }
}
