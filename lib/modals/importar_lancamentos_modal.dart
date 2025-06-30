// lib/modals/importar_lancamentos_modal.dart

import 'package:flutter/material.dart';

class ImportarLancamentosModal extends StatefulWidget {
  const ImportarLancamentosModal({super.key});

  @override
  State<ImportarLancamentosModal> createState() =>
      _ImportarLancamentosModalState();
}

class _ImportarLancamentosModalState extends State<ImportarLancamentosModal> {
  String _importOption = 'Apenas importar lançamentos';
  bool _applyRules = true;
  bool _invertSignal = false;
  bool _saveDescription = false;
  bool _disregardDocNumber = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: MediaQuery.of(context).size.width * 0.4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Importar lançamentos',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop()),
              ],
            ),
            const SizedBox(height: 24),

            // Dropdown de Opção de Importação
            DropdownButtonFormField<String>(
              value: _importOption,
              items: const [
                DropdownMenuItem(
                    value: 'Apenas importar lançamentos',
                    child: Text('Apenas importar lançamentos')),
                DropdownMenuItem(
                    value: 'Conciliar com lançamentos da conta',
                    child: Text('Conciliar com lançamentos da conta')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _importOption = value;
                  });
                }
              },
            ),
            const SizedBox(height: 24),

            // Conteúdo dinâmico
            Flexible(
              child: SingleChildScrollView(
                child: _importOption == 'Apenas importar lançamentos'
                    ? _buildImportView()
                    : _buildConciliarView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // View para "Apenas importar lançamentos"
  Widget _buildImportView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          value: 'OFX/OFC',
          items: const [
            DropdownMenuItem(value: 'OFX/OFC', child: Text('OFX/OFC')),
            DropdownMenuItem(
                value: 'Planilha Excel (xls/xlsx)',
                child: Text('Planilha Excel (xls/xlsx)')),
            DropdownMenuItem(
                value: 'Planilha Excel (csv)',
                child: Text('Planilha Excel (csv)')),
            DropdownMenuItem(value: 'QIF', child: Text('QIF')),
            DropdownMenuItem(value: 'PDF', child: Text('PDF')),
          ],
          onChanged: (value) {},
          decoration: const InputDecoration(labelText: 'Fonte dos lançamentos'),
        ),
        const SizedBox(height: 24),
        const Text('Observações:',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const Text(
            '1. Recomendamos que sejam utilizados arquivos com no máximo 500 lançamentos'),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.upload_file),
            label: const Text('Escolher arquivo (.ofx|.ofc)'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20),
              backgroundColor: const Color(0xFF00BFA5),
              foregroundColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildWarningBanner(),
        _buildCheckbox('Inverter sinal dos valores do arquivo escolhido',
            _invertSignal, (val) => setState(() => _invertSignal = val!)),
        _buildCheckbox('Aplicar regras de preenchimento', _applyRules,
            (val) => setState(() => _applyRules = val!)),
        _buildCheckbox('Salvar descrição original como Observações',
            _saveDescription, (val) => setState(() => _saveDescription = val!)),
        _buildCheckbox(
            'Desconsiderar número de documento do arquivo importado',
            _disregardDocNumber,
            (val) => setState(() => _disregardDocNumber = val!)),
      ],
    );
  }

  // View para "Conciliar com lançamentos da conta"
  Widget _buildConciliarView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('CONTA CORRENTE',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
        ListTile(
          leading: const Icon(Icons.account_balance_wallet),
          title: const Text('Conta corrente'),
          onTap: () {},
        ),
        const SizedBox(height: 16),
        const Text('CARTÃO DE CRÉDITO',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
        ListTile(
          leading: const Icon(Icons.credit_card),
          title: const Text('Yuri Yuri'),
          onTap: () {},
        ),
        const SizedBox(height: 24),
        _buildWarningBanner(),
        _buildCheckbox('Inverter sinal dos valores do arquivo escolhido',
            _invertSignal, (val) => setState(() => _invertSignal = val!)),
      ],
    );
  }

  Widget _buildCheckbox(String title, bool value, Function(bool?) onChanged) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Flexible(child: Text(title)),
      ],
    );
  }

  Widget _buildWarningBanner() {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        // CORRIGIDO: de withOpacity(0.5) para withAlpha(128)
        color: Colors.yellow[700]?.withAlpha(128),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.black87),
          SizedBox(width: 8),
          Flexible(
              child: Text(
                  'Por razões de segurança, o MD suporta o upload de arquivos de no máximo 5Mb.')),
        ],
      ),
    );
  }
}
