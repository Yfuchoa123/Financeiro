// lib/modals/nova_regra_modal.dart

import 'package:flutter/material.dart';

enum TipoRegra { despesa, receita, transferencia }

class NovaRegraModal extends StatefulWidget {
  const NovaRegraModal({super.key});

  @override
  State<NovaRegraModal> createState() => _NovaRegraModalState();
}

class _NovaRegraModalState extends State<NovaRegraModal> {
  TipoRegra _tipoRegra = TipoRegra.despesa;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        width: screenWidth * 0.4,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Nova regra de preenchimento',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop()),
              ],
            ),
            const SizedBox(height: 24),
            // Seleção de Tipo
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildRadioOption(TipoRegra.despesa, 'Despesa'),
                const SizedBox(width: 16),
                _buildRadioOption(TipoRegra.receita, 'Receita'),
                const SizedBox(width: 16),
                _buildRadioOption(TipoRegra.transferencia, 'Transferência'),
              ],
            ),
            const SizedBox(height: 24),
            // Campos Dinâmicos
            _buildDynamicFields(),
            const SizedBox(height: 24),
            // Switch
            Row(
              children: [
                Switch(value: false, onChanged: (val) {}),
                const SizedBox(width: 8),
                const Flexible(
                    child: Text(
                        'Ao importar lançamentos, substituir a descrição do extrato por .')),
              ],
            ),
            const SizedBox(height: 32),
            // Rodapé
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {},
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

  Widget _buildRadioOption(TipoRegra value, String title) {
    return InkWell(
      onTap: () => setState(() => _tipoRegra = value),
      child: Row(
        children: [
          Radio<TipoRegra>(
            value: value,
            groupValue: _tipoRegra,
            onChanged: (TipoRegra? newValue) {
              setState(() {
                _tipoRegra = newValue!;
              });
            },
          ),
          Text(title),
        ],
      ),
    );
  }

  Widget _buildDynamicFields() {
    if (_tipoRegra == TipoRegra.transferencia) {
      // Campos para Transferência
      return Column(
        children: [
          TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Palavras chave (separadas por vírgula) *',
                  counterText: '0/200')),
          const SizedBox(height: 16),
          TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Descrição dos lançamentos *',
                  counterText: '0/200')),
          const SizedBox(height: 16),
          const Row(
            children: [
              Expanded(
                  child: TextField(
                      decoration: InputDecoration(labelText: 'Conta origem'))),
              SizedBox(width: 16),
              Expanded(
                  child: TextField(
                      decoration: InputDecoration(labelText: 'Conta destino'))),
              SizedBox(width: 16),
              Expanded(
                  child: TextField(
                      decoration:
                          InputDecoration(labelText: 'Tipo de transferência'))),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(decoration: const InputDecoration(labelText: 'Tags')),
        ],
      );
    } else {
      // Campos para Despesa e Receita
      return Column(
        children: [
          TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Palavras chave (separadas por vírgula) *',
                  counterText: '0/200')),
          const SizedBox(height: 16),
          TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Descrição dos lançamentos *',
                  counterText: '0/200')),
          const SizedBox(height: 16),
          const Row(
            children: [
              Expanded(
                  child: TextField(
                      decoration: InputDecoration(labelText: 'Conta'))),
              SizedBox(width: 16),
              Expanded(
                  child: TextField(
                      decoration: InputDecoration(labelText: 'Categoria'))),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(decoration: const InputDecoration(labelText: 'Tags')),
        ],
      );
    }
  }
}
