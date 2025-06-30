import 'package:flutter/material.dart';

class SaldosDeCaixaCard extends StatefulWidget {
  const SaldosDeCaixaCard({super.key});

  @override
  State<SaldosDeCaixaCard> createState() => _SaldosDeCaixaCardState();
}

class _SaldosDeCaixaCardState extends State<SaldosDeCaixaCard> {
  bool _showContaCorrente = true;
  bool _showSaldoMetas = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Saldos de caixa',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                SizedBox(width: 32),
                Expanded(child: Text('')),
                SizedBox(
                    width: 80,
                    child: Text('Confirmado',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 12))),
                SizedBox(
                    width: 80,
                    child: Text('Projetado',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 12))),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Checkbox(
                  value: _showContaCorrente,
                  onChanged: (val) {
                    setState(() {
                      _showContaCorrente = val!;
                    });
                  },
                ),
                const Expanded(child: Text('Conta corrente')),
                SizedBox(
                    width: 80,
                    child: Text('2.131,32',
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.green[700]))),
                SizedBox(
                    width: 80,
                    child: Text('2.131,32',
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.green[700]))),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: _showSaldoMetas,
                  onChanged: (val) {
                    setState(() {
                      _showSaldoMetas = val!;
                    });
                  },
                ),
                const Expanded(child: Text('Saldo de resíduo de metas')),
                const SizedBox(
                    width: 80, child: Text('-', textAlign: TextAlign.right)),
                SizedBox(
                    width: 80,
                    child: Text('-100,00',
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.red[700]))),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const SizedBox(width: 32),
                const Expanded(
                    child: Text('Total',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                SizedBox(
                    width: 80,
                    child: Text('2.131,32',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold))),
                SizedBox(
                    width: 80,
                    child: Text('2.031,32',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
