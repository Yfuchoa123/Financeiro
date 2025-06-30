import 'package:flutter/material.dart';
import 'package:meu_financeiro_pessoal/modals/definir_repeticao_modal.dart';
import 'package:meu_financeiro_pessoal/utils/currency_input_formatter.dart';

class NovaReceitaModal extends StatefulWidget {
  const NovaReceitaModal({super.key});

  @override
  State<NovaReceitaModal> createState() => _NovaReceitaModalState();
}

class _NovaReceitaModalState extends State<NovaReceitaModal> {
  DateTime _selectedDate = DateTime.now();
  String _repetition = 'Única';
  final List<String> _repetitionOptions = ['Única', 'Parcelada', 'Fixa'];

  final TextEditingController _valorController = TextEditingController();

  @override
  void dispose() {
    _valorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: screenWidth * 0.5,
        height: screenHeight * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Nova receita',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.arrow_drop_down, color: Colors.grey[700]),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.grey),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _valorController,
                            decoration: const InputDecoration(
                              labelText: 'Valor (R\$)*',
                              hintText: '0,00',
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              CurrencyInputFormatter(),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  _selectedDate = pickedDate;
                                });
                              }
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Data*',
                                  suffixIcon: Icon(Icons.calendar_today),
                                ),
                                controller: TextEditingController(
                                    text:
                                        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _repetition,
                            items: _repetitionOptions.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _repetition = newValue!;
                              });
                            },
                            decoration:
                                const InputDecoration(labelText: 'Repetição'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Tooltip(
                          message: 'Única: sem previsão de se repetir.\n'
                              'Parcelada: com repetição e data final conhecidos.\n'
                              'Fixa: com repetição conhecida mas data final desconhecida.',
                          child: Icon(Icons.help_outline,
                              size: 20, color: Colors.grey),
                        ),
                        IconButton(
                          icon: const Icon(Icons.settings, size: 20),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  const DefinirRepeticaoModal(),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (_repetition == 'Parcelada')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: TextFormField(
                                      decoration: const InputDecoration(
                                          labelText: 'Periodicidade*'),
                                      initialValue: 'mensal')),
                              const SizedBox(width: 24),
                              Expanded(
                                  child: TextFormField(
                                      decoration: const InputDecoration(
                                          labelText: 'Número de parcelas*'),
                                      initialValue: '2')),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text('2 parcelas de R\$13.121,32',
                                style: TextStyle(color: Colors.grey[600])),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    if (_repetition == 'Fixa')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: TextFormField(
                                      decoration: const InputDecoration(
                                          labelText: 'Periodicidade*'),
                                      initialValue: 'mensal')),
                              const SizedBox(width: 24),
                              Expanded(
                                  child: TextFormField(
                                      decoration: const InputDecoration(
                                          labelText:
                                              'Repete-se a cada n meses *'),
                                      initialValue: '1')),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Expanded(
                            child: TextField(
                                decoration:
                                    InputDecoration(labelText: 'Descrição'))),
                        SizedBox(width: 24),
                        Expanded(
                            child: TextField(
                                decoration:
                                    InputDecoration(labelText: 'Conta*'))),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Expanded(
                            child: TextField(
                                decoration:
                                    InputDecoration(labelText: 'Categoria*'))),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const TextField(
                        decoration: InputDecoration(labelText: 'Observações')),
                    const SizedBox(height: 16),
                    const TextField(
                        decoration: InputDecoration(labelText: 'Tags')),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            const Divider(height: 1, color: Colors.grey),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          icon: const Icon(Icons.check_circle_outline,
                              color: Colors.green),
                          onPressed: () {}),
                      IconButton(
                          icon: const Icon(Icons.check), onPressed: () {}),
                      IconButton(
                          icon: const Icon(Icons.attachment), onPressed: () {}),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00BFA5)),
                        child: const Text('Salvar'),
                      ),
                      const SizedBox(width: 8),
                      FloatingActionButton(
                        mini: true,
                        onPressed: () {},
                        backgroundColor: const Color(0xFF00BFA5),
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
