// lib/screens/configuracoes_utilizacao_screen.dart

import 'package:flutter/material.dart';
import 'package:meu_financeiro_pessoal/modals/personalizar_cores_modal.dart'; // <-- IMPORT ADICIONADO
import 'package:meu_financeiro_pessoal/widgets/custom_app_bar.dart';

class ConfiguracoesUtilizacaoScreen extends StatefulWidget {
  const ConfiguracoesUtilizacaoScreen({super.key});

  @override
  State<ConfiguracoesUtilizacaoScreen> createState() =>
      _ConfiguracoesUtilizacaoScreenState();
}

class _ConfiguracoesUtilizacaoScreenState
    extends State<ConfiguracoesUtilizacaoScreen> {
  // Estados de exemplo para os switches
  bool _contatosObrigatorio = false;
  bool _centrosObrigatorio = true;
  String _padraoParcelamento = 'Automático';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Configurações de utilização'),
      //   backgroundColor: const Color(0xFF00BFA5),
      //   foregroundColor: Colors.white,
      // ),
      // ADICIONE ISTO NO LUGAR:
      appBar: const CustomAppBar(title: 'Configurações de utilização'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Wrap(
          spacing: 24.0,
          runSpacing: 24.0,
          children: [
            // Linha 1
            _buildConfigCard(
              title: 'Data de competência',
              description:
                  'Utilizar o campo data de competência nos lançamentos.',
              status: false,
              actionWidget: OutlinedButton(
                onPressed: () {},
                child: const Text('Configurações adicionais'),
              ),
            ),
            _buildConfigCard(
              title: 'Resíduo de metas',
              description:
                  'Considerar os valores residuais das metas de receitas e despesas nos resultados dos relatórios de caixa.',
              status: true,
            ),
            _buildConfigCard(
                title: 'Contatos',
                description:
                    'Utilizar o cadastro de contatos, adicionando o campo aos lançamentos.',
                status: false,
                actionWidget: Row(
                  children: [
                    Switch(
                        value: _contatosObrigatorio,
                        onChanged: (val) =>
                            setState(() => _contatosObrigatorio = val)),
                    const Text('Obrigatório'),
                  ],
                )),
            // Linha 2
            _buildConfigCard(
                title: 'Centros',
                description:
                    'Utilizar o cadastro de centros de custos e lucros, adicionando o campo aos lançamentos.',
                status: true,
                actionWidget: Row(
                  children: [
                    Switch(
                        value: _centrosObrigatorio,
                        onChanged: (val) =>
                            setState(() => _centrosObrigatorio = val)),
                    const Text('Obrigatório'),
                  ],
                )),
            _buildConfigCard(
                title: 'Formas de pagamento',
                description:
                    'Utilizar o cadastro de formas de pagamento, adicionando o campo aos lançamentos.',
                status: false,
                actionWidget: Row(
                  children: [
                    Switch(value: false, onChanged: (val) {}),
                    const Text('Obrigatório'),
                  ],
                )),
            _buildConfigCard(
                title: 'Projetos',
                description:
                    'Utilizar o cadastro de projetos, adicionando o campo aos lançamentos.',
                status: false,
                actionWidget: Row(
                  children: [
                    Switch(value: false, onChanged: (val) {}),
                    const Text('Obrigatório'),
                  ],
                )),
            // Linha 3
            _buildConfigCard(
              title: 'Tags',
              description:
                  'Utilizar o cadastro de tags, adicionando o campo aos lançamentos.',
              status: true,
            ),
            _buildConfigCard(
                title: 'Número de documento',
                description:
                    'Utilizar o campo número de documento nos lançamentos.',
                status: false,
                actionWidget: Row(
                  children: [
                    Switch(value: false, onChanged: (val) {}),
                    const Text('Obrigatório'),
                  ],
                )),
            _buildConfigCard(
              title: 'Campo de observações',
              description: 'Utilizar o campo observações nos lançamentos.',
              status: true,
            ),
            // Linha 4
            _buildConfigCard(
              title: 'Senha para exclusão de cadastros',
              description:
                  'Exigir a senha de acesso para a exclusão de um item dos cadastros.',
              status: true,
            ),
            _buildConfigCard(
              title: 'Metas de receitas e despesas',
              description:
                  'Considerar na apuração do valor realizado apenas os lançamentos em cuja categoria há meta definida.',
              status: false,
            ),
            _buildConfigCard(
              title: 'Exibir os lançamentos pendentes no presente',
              description:
                  'Ao desabilitar esta opção, os lançamentos pendentes serão considerados no dia do seu vencimento.',
              status: true,
            ),
            // Linha 5
            _buildConfigCard(
              title: 'Padrão de parcelamento',
              description:
                  'Definir se o padrão será o Valor da Parcela ou o Valor Total na criação de lançamentos parcelados',
              status:
                  true, // Apenas para o pontinho verde, não há ação de habilitar/desabilitar
              actionWidget: DropdownButton<String>(
                value: _padraoParcelamento,
                onChanged: (String? newValue) {
                  setState(() {
                    _padraoParcelamento = newValue!;
                  });
                },
                items: <String>['Automático', 'Valor da Parcela', 'Valor Total']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            // CARD DE ACESSIBILIDADE ATUALIZADO
            _buildConfigCard(
              title: 'Acessibilidade',
              description: 'Personalizar esquemas de cores do sistema.',
              status: true,
              actionText: 'Personalizar',
              onActionTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const PersonalizarCoresModal(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget reutilizável para cada card de configuração
  Widget _buildConfigCard({
    required String title,
    required String description,
    required bool status,
    Widget? actionWidget,
    String? actionText,
    VoidCallback? onActionTap,
  }) {
    // Determina o texto e a cor da ação principal (Habilitar/Desabilitar)
    final mainActionText = status ? 'Desabilitar' : 'Habilitar';
    final mainActionColor = status ? Colors.pink : Colors.teal;

    return SizedBox(
      width: 450, // Largura fixa para cada card
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Icon(Icons.circle,
                      color: status ? Colors.green : Colors.grey[300],
                      size: 16),
                ],
              ),
              const SizedBox(height: 8),
              Text(description, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (actionWidget != null)
                    Expanded(child: actionWidget)
                  else
                    const Spacer(), // Ocupa espaço se não houver widget de ação

                  if (actionText ==
                      null) // Se não houver texto de ação customizado, mostra Habilitar/Desabilitar
                    TextButton(
                      onPressed: onActionTap ?? () {},
                      child: Text(mainActionText,
                          style: TextStyle(color: mainActionColor)),
                    )
                  else // Se houver, mostra o botão customizado
                    TextButton(
                      onPressed: onActionTap ?? () {},
                      child: Text(actionText,
                          style: const TextStyle(color: Colors.pink)),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
