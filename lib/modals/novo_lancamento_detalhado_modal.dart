import 'package:flutter/material.dart';
import 'package:meu_financeiro_pessoal/utils/currency_input_formatter.dart';

class NovoLancamentoDetalhadoModal extends StatefulWidget {
  const NovoLancamentoDetalhadoModal({super.key});

  @override
  State<NovoLancamentoDetalhadoModal> createState() =>
      _NovoLancamentoDetalhadoModalState();
}

class _NovoLancamentoDetalhadoModalState
    extends State<NovoLancamentoDetalhadoModal> {
  DateTime _selectedDate = DateTime.now();

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
                  const Text(
                    'Novo lançamento detalhado',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                                initialDate: _selectedDate,
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
                      ],
                    ),
                    const SizedBox(height: 16),
                    const TextField(
                        decoration: InputDecoration(labelText: 'Descrição')),
                    const SizedBox(height: 16),
                    const TextField(
                        decoration: InputDecoration(labelText: 'Conta*')),
                    const SizedBox(height: 16),
                    const TextField(
                        decoration: InputDecoration(labelText: 'Categoria*')),
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
