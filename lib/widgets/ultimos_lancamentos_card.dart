import 'package:flutter/material.dart';

class UltimosLancamentosCard extends StatelessWidget {
  const UltimosLancamentosCard({super.key});

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
              'Últimos lançamentos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // Lançamento 1
                  ListTile(
                    leading: const Icon(
                      Icons.wifi,
                      color: Colors.blue,
                    ), // Ícone de Internet
                    title: const Text('Internet 1/6'),
                    subtitle: const Text('Conta corrente'),
                    trailing: Text(
                      '-R\$ 100,00',
                      style: TextStyle(
                        color: Colors.red[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(),
                  // Lançamento 2
                  ListTile(
                    leading: const Icon(
                      Icons.attach_money,
                      color: Colors.green,
                    ), // Ícone de dinheiro
                    title: const Text('Salão Inicial'),
                    subtitle: const Text('Conta corrente'),
                    trailing: Text(
                      'R\$ 0,00',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(),
                  // Adicione mais lançamentos aqui
                  ListTile(
                    leading: const Icon(
                      Icons.shopping_cart,
                      color: Colors.purple,
                    ),
                    title: const Text('Compras no mercado'),
                    subtitle: const Text('Cartão de crédito'),
                    trailing: Text(
                      '-R\$ 50,00',
                      style: TextStyle(
                        color: Colors.red[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.restaurant, color: Colors.orange),
                    title: const Text('Restaurante'),
                    subtitle: const Text('Conta corrente'),
                    trailing: Text(
                      '-R\$ 80,00',
                      style: TextStyle(
                        color: Colors.red[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
