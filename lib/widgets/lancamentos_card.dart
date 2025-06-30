import 'package:flutter/material.dart';

class LancamentosCard extends StatefulWidget {
  const LancamentosCard({super.key});

  @override
  State<LancamentosCard> createState() => _LancamentosCardState();
}

class _LancamentosCardState extends State<LancamentosCard> {
  final List<Map<String, dynamic>> _lancamentos = [
    {
      'date': 'hoje',
      'description': 'asdasdasasd',
      'account': 'Conta corrente',
      'value': 1231.32,
      'type': 'credit',
      'tags': [],
    },
    {
      'date': 'hoje',
      'description': 'adsasd',
      'account': 'Conta corrente',
      'value': 1000.00,
      'type': 'credit',
      'tags': [],
    },
    {
      'date': '20/07/25',
      'description': 'Aplicação programada 1/12',
      'account': 'Conta corrente',
      'transfer_to': 'Yuri Yuri',
      'value': 17079.28,
      'type': 'transfer',
      'tags': [],
    },
    {
      'date': 'hoje',
      'description': 'Aplicação programada 1/12',
      'account': 'Yuri Forte',
      'transfer_from': 'Conta corrente',
      'value': -17079.28,
      'type': 'transfer',
      'is_paid': true,
      'tags': [],
    },
    {
      'date': '24/07/25',
      'description': 'Internet 2/6',
      'account': 'Conta corrente',
      'value': -100.00,
      'type': 'debit',
      'tags': ['Internet'],
    },
    {
      'date': 'hoje',
      'description': 'Internet 1/6',
      'account': 'Conta corrente',
      'value': -100.00,
      'type': 'debit',
      'tags': ['Internet'],
    },
    {
      'date': 'hoje',
      'description': 'Saldo inicial',
      'account': 'Conta corrente',
      'value': 0.00,
      'type': 'credit',
      'tags': [],
    },
  ];

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
              child: ListView.separated(
                itemCount: _lancamentos.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final lancamento = _lancamentos[index];
                  final isNegative = lancamento['value'] < 0;
                  final isTransfer = lancamento['type'] == 'transfer';
                  final hasTags = lancamento['tags'] != null &&
                      lancamento['tags'].isNotEmpty;

                  return ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          lancamento['date'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            lancamento['description'],
                            style: const TextStyle(fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (hasTags)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.red[100],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              lancamento['tags'][0],
                              style: TextStyle(
                                  color: Colors.red[800], fontSize: 10),
                            ),
                          ),
                      ],
                    ),
                    subtitle: isTransfer
                        ? Row(
                            children: [
                              Flexible(
                                child: Text(
                                  '${lancamento['account']}',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(Icons.arrow_right_alt, size: 16),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  '${lancamento['transfer_to'] ?? lancamento['transfer_from'] ?? ''}',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          )
                        : Text(lancamento['account']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'R\$ ${lancamento['value'].toStringAsFixed(2)}',
                          style: TextStyle(
                            color: isNegative
                                ? Colors.red[700]
                                : Colors.green[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
