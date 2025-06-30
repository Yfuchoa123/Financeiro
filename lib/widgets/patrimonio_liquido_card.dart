import 'package:flutter/material.dart';

class PatrimonioLiquidoCard extends StatefulWidget {
  const PatrimonioLiquidoCard({super.key});

  @override
  State<PatrimonioLiquidoCard> createState() => _PatrimonioLiquidoCardState();
}

class _PatrimonioLiquidoCardState extends State<PatrimonioLiquidoCard> {
  final double ativoValue = 131.32; // Ajustado para não transbordar
  final double passivoValue = -100.00;

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
              'Balanço patrimonial',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Center(
                child: SizedBox(
                  height: 150, // Altura fixa para a área do gráfico
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 30,
                            height: ativoValue * 0.05,
                            color: Colors.green,
                          ),
                          const SizedBox(height: 8),
                          const Text('Ativo', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Passivo', style: TextStyle(fontSize: 12)),
                          const SizedBox(height: 8),
                          Container(
                            width: 5, // Largura fina para ser vertical
                            height: passivoValue.abs() * 0.2, // Aumenta a escala para ser visível
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Ativo', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('0,00', style: TextStyle(color: Colors.green[700])),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Disponível', style: TextStyle(color: Colors.green)),
                    Text('0,00', style: TextStyle(color: Colors.green[700])),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Realizável', style: TextStyle(color: Colors.green)),
                    Text('0,00', style: TextStyle(color: Colors.green[700])),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Passivo', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('-100,00', style: TextStyle(color: Colors.red[700])),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Devedor', style: TextStyle(color: Colors.red)),
                    Text('-100,00', style: TextStyle(color: Colors.red[700])),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Exigível', style: TextStyle(color: Colors.red)),
                    Text('0,00', style: TextStyle(color: Colors.red[700])),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Patrimônio líquido', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('-R\$ 100,00', style: TextStyle(color: Colors.red[700], fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}