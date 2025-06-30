// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io'; // Import para verificar a plataforma (Windows, etc.)
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Import para a inicialização do DB no desktop

// Modais
import 'package:meu_financeiro_pessoal/modals/fechamento_posicao_modal.dart';
import 'package:meu_financeiro_pessoal/modals/importar_lancamentos_modal.dart';
import 'package:meu_financeiro_pessoal/modals/nova_despesa_modal.dart';
import 'package:meu_financeiro_pessoal/modals/nova_receita_modal.dart';
import 'package:meu_financeiro_pessoal/modals/nova_transferencia_modal.dart';
import 'package:meu_financeiro_pessoal/modals/novo_lancamento_detalhado_modal.dart';

// Telas
import 'package:meu_financeiro_pessoal/screens/cadastros/categorias_screen.dart';
import 'package:meu_financeiro_pessoal/screens/cadastros/contas_screen.dart';
import 'package:meu_financeiro_pessoal/screens/cadastros/tags_screen.dart';
import 'package:meu_financeiro_pessoal/screens/cartoes_de_credito_screen.dart';
import 'package:meu_financeiro_pessoal/screens/configuracoes_utilizacao_screen.dart';
import 'package:meu_financeiro_pessoal/screens/contas_pagar_receber_screen.dart';
import 'package:meu_financeiro_pessoal/screens/contas_pagas_recebidas_screen.dart';
import 'package:meu_financeiro_pessoal/screens/documentos_screen.dart';
import 'package:meu_financeiro_pessoal/screens/extrato_de_contas_screen.dart';
import 'package:meu_financeiro_pessoal/screens/fluxo_de_caixa_screen.dart';
import 'package:meu_financeiro_pessoal/screens/lancamentos_screen.dart';
import 'package:meu_financeiro_pessoal/screens/metas_de_orcamento_screen.dart';
import 'package:meu_financeiro_pessoal/screens/metas_economia_screen.dart';
import 'package:meu_financeiro_pessoal/screens/regras_preenchimento_screen.dart';
import 'package:meu_financeiro_pessoal/screens/relatorios_screen.dart';

// Widgets
import 'package:meu_financeiro_pessoal/widgets/custom_app_bar.dart';
import 'package:meu_financeiro_pessoal/widgets/custom_menu_item.dart';
import 'package:meu_financeiro_pessoal/widgets/fluxo_de_caixa_card.dart';
import 'package:meu_financeiro_pessoal/widgets/lancamentos_card.dart';
import 'package:meu_financeiro_pessoal/widgets/patrimonio_liquido_card.dart';
import 'package:meu_financeiro_pessoal/widgets/resultados_de_caixa_card.dart';
import 'package:meu_financeiro_pessoal/widgets/saldos_de_caixa_card.dart';

// Função principal agora é async para aguardar a inicialização
Future<void> main() async {
  // Garante que o Flutter está pronto
  WidgetsFlutterBinding.ensureInitialized();

  // Se for uma plataforma de desktop, inicializa a "ponte" do banco de dados
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Meu Financeiro Pessoal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF00BFA5),
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        scaffoldBackgroundColor: Colors.grey[100],
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // --- Variáveis de estado ---
  bool _isMovimentacoesExpanded = false;
  bool _isMetasExpanded = false;
  bool _isCadastrosExpanded = true;
  bool _isCustomDrawerOpen = false;
  bool _isFabMenuOpen = false;
  static const double _drawerWidth = 304.0;

  void _toggleFabMenu() {
    setState(() {
      _isFabMenuOpen = !_isFabMenuOpen;
    });
  }

  // --- Função para mostrar o modal ---
  void _showModal(BuildContext context, Widget modal) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return modal;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Visão geral',
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            setState(() {
              _isCustomDrawerOpen = !_isCustomDrawerOpen;
            });
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon:
                  const Icon(Icons.account_balance_wallet, color: Colors.white),
              label: const Text('Assinar o Meu Dinheiro',
                  style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                side: const BorderSide(color: Colors.white, width: 1),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
          ),
          IconButton(icon: const Icon(Icons.credit_card), onPressed: () {}),
          IconButton(icon: const Icon(Icons.help_outline), onPressed: () {}),
          IconButton(icon: const Icon(Icons.calendar_month), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(
              'Y',
              style: TextStyle(
                color: Theme.of(context).appBarTheme.backgroundColor,
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_drop_down),
          const SizedBox(width: 8),
        ],
      ),
      body: Row(
        children: [
          // --- Nosso Menu Lateral Customizado ---
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: _isCustomDrawerOpen ? _drawerWidth : 0,
            color: Colors.white,
            curve: Curves.easeInOut,
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: <Widget>[
                CustomMenuItem(
                  icon: Icons.dashboard_outlined,
                  title: 'Visão geral',
                  isSelected: true,
                  isFavoritable: true,
                  onTap: () {
                    setState(() {
                      _isCustomDrawerOpen = false;
                    });
                  },
                ),
                CustomMenuItem(
                  icon: Icons.bar_chart_outlined,
                  title: 'Movimentações e caixa',
                  initiallyExpanded: _isMovimentacoesExpanded,
                  onExpansionChanged: (bool expanded) {
                    setState(() {
                      _isMovimentacoesExpanded = expanded;
                    });
                  },
                  children: <Widget>[
                    CustomMenuItem(
                        title: 'Lançamentos',
                        onTap: () {
                          setState(() {
                            _isCustomDrawerOpen = false;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const LancamentosScreen()));
                        }),
                    CustomMenuItem(
                        title: 'Fluxo',
                        onTap: () {
                          setState(() {
                            _isCustomDrawerOpen = false;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const FluxoDeCaixaScreen()));
                        }),
                    CustomMenuItem(
                        title: 'A pagar e receber',
                        onTap: () {
                          setState(() {
                            _isCustomDrawerOpen = false;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ContasPagarReceberScreen()));
                        }),
                    CustomMenuItem(
                        title: 'Pagas e recebidas',
                        onTap: () {
                          setState(() {
                            _isCustomDrawerOpen = false;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ContasPagasRecebidasScreen()));
                        }),
                  ],
                  onTap: () {},
                ),
                CustomMenuItem(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'Extrato de contas',
                  isFavoritable: true,
                  onTap: () {
                    setState(() {
                      _isCustomDrawerOpen = false;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ExtratoDeContasScreen()));
                  },
                ),
                CustomMenuItem(
                  icon: Icons.credit_card,
                  title: 'Cartões de Crédito', // CORRIGIDO: de 'text' para 'title'
                  onTap: () {
                    Navigator.pop(context); // Fecha o drawer
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartoesDeCreditoScreen()),
                    );
                  },
                ),
                CustomMenuItem(
                  icon: Icons.insert_chart_outlined,
                  title: 'Metas',
                  initiallyExpanded: _isMetasExpanded,
                  onExpansionChanged: (bool expanded) {
                    setState(() {
                      _isMetasExpanded = expanded;
                    });
                  },
                  children: <Widget>[
                    CustomMenuItem(
                        title: 'Orçamento',
                        onTap: () {
                          setState(() {
                            _isCustomDrawerOpen = false;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MetasDeOrcamentoScreen()));
                        }),
                    CustomMenuItem(
                        title: 'Economia',
                        onTap: () {
                          setState(() {
                            _isCustomDrawerOpen = false;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MetasEconomiaScreen()));
                        }),
                  ],
                  onTap: () {},
                ),
                CustomMenuItem(
                  icon: Icons.description_outlined,
                  title: 'Relatórios',
                  isFavoritable: true,
                  onTap: () {
                    setState(() {
                      _isCustomDrawerOpen = false;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RelatoriosScreen()));
                  },
                ),
                CustomMenuItem(
                  icon: Icons.trending_up_outlined,
                  title: 'Investimentos',
                  onTap: () {
                    setState(() {
                      _isCustomDrawerOpen = false;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PlaceholderScreen(
                                title: 'Investimentos')));
                  },
                ),
                CustomMenuItem(
                  icon: Icons.folder_open_outlined,
                  title: 'Cadastros',
                  initiallyExpanded: _isCadastrosExpanded,
                  onExpansionChanged: (bool expanded) {
                    setState(() {
                      _isCadastrosExpanded = expanded;
                    });
                  },
                  children: <Widget>[
                    CustomMenuItem(
                        title: 'Categorias',
                        onTap: () {
                          setState(() {
                            _isCustomDrawerOpen = false;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CategoriasScreen()));
                        }),
                    CustomMenuItem(
                        title: 'Contas',
                        onTap: () {
                          setState(() {
                            _isCustomDrawerOpen = false;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ContasScreen()));
                        }),
                    CustomMenuItem(
                        title: 'Tags',
                        onTap: () {
                          setState(() {
                            _isCustomDrawerOpen = false;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TagsScreen()));
                        }),
                  ],
                  onTap: () {},
                ),
                CustomMenuItem(
                  icon: Icons.description_outlined,
                  title: 'Documentos',
                  onTap: () {
                    setState(() {
                      _isCustomDrawerOpen = false;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DocumentosScreen()));
                  },
                ),
                CustomMenuItem(
                  icon: Icons.rule_folder_outlined,
                  title: 'Regras de preenchimento',
                  onTap: () {
                    setState(() {
                      _isCustomDrawerOpen = false;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const RegrasPreenchimentoScreen()));
                  },
                ),
                CustomMenuItem(
                  icon: Icons.pets_outlined,
                  title: 'Carnê Leão',
                  onTap: () {
                    setState(() {
                      _isCustomDrawerOpen = false;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const PlaceholderScreen(title: 'Carnê Leão')));
                  },
                ),
                CustomMenuItem(
                  icon: Icons.upload_file_outlined,
                  title: 'Importar lançamentos',
                  onTap: () {
                    setState(() {
                      _isCustomDrawerOpen = false;
                    });
                    _showModal(context, const ImportarLancamentosModal());
                  },
                ),
                CustomMenuItem(
                  icon: Icons.lock_outline,
                  title: 'Fechamento posição',
                  onTap: () {
                    setState(() {
                      _isCustomDrawerOpen = false;
                    });
                    _showModal(context, const FechamentoPosicaoModal());
                  },
                ),
                CustomMenuItem(
                  icon: Icons.settings_outlined,
                  title: 'Configurações de utilização',
                  onTap: () {
                    setState(() {
                      _isCustomDrawerOpen = false;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ConfiguracoesUtilizacaoScreen()));
                  },
                ),
                const Divider(),
                CustomMenuItem(
                  icon: Icons.settings,
                  title: 'Versão 8.1.3.2.15.28',
                  onTap: () {/* Não faz nada */},
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Wrap(
                    spacing: 16.0,
                    runSpacing: 16.0,
                    children: [
                      SizedBox(
                        width: 500,
                        height: 300,
                        child: const FluxoDeCaixaCard(),
                      ),
                      SizedBox(
                        width: 400,
                        height: 250,
                        child: const SaldosDeCaixaCard(),
                      ),
                      SizedBox(
                        width: 400,
                        height: 350,
                        child: const ResultadosDeCaixaCard(), // O erro do 'text' já estava corrigido por você aqui
                      ),
                      SizedBox(
                        width: 500,
                        height: 350,
                        child: const PatrimonioLiquidoCard(),
                      ),
                      SizedBox(
                        width: 400,
                        height: 600,
                        child: const LancamentosCard(),
                      ),
                    ],
                  ),
                ),
                if (_isCustomDrawerOpen)
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isCustomDrawerOpen = false;
                        });
                      },
                      child: AnimatedOpacity(
                        opacity: _isCustomDrawerOpen ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        child: Container(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (_isFabMenuOpen)
            FloatingActionButton.extended(
              heroTag: 'lancamentoDetalhadoBtn',
              onPressed: () {
                _toggleFabMenu();
                _showModal(context, const NovoLancamentoDetalhadoModal());
              },
              label: const Text('Lançamento detalhado',
                  style: TextStyle(color: Colors.white)),
              icon: const Icon(Icons.share, color: Colors.white),
              backgroundColor: const Color(0xFF9C27B0),
            ),
          if (_isFabMenuOpen) const SizedBox(height: 10),
          if (_isFabMenuOpen)
            FloatingActionButton.extended(
              heroTag: 'transferenciaBtn',
              onPressed: () {
                _toggleFabMenu();
                _showModal(context, const NovaTransferenciaModal());
              },
              label: const Text('Transferência',
                  style: TextStyle(color: Colors.white)),
              icon: const Icon(Icons.compare_arrows, color: Colors.white),
              backgroundColor: const Color(0xFF9C27B0),
            ),
          if (_isFabMenuOpen) const SizedBox(height: 10),
          if (_isFabMenuOpen)
            FloatingActionButton.extended(
              heroTag: 'receitaBtn',
              onPressed: () {
                _toggleFabMenu();
                _showModal(context, const NovaReceitaModal());
              },
              label:
                  const Text('Receita', style: TextStyle(color: Colors.white)),
              icon: const Icon(Icons.arrow_upward, color: Colors.white),
              backgroundColor: const Color(0xFFE91E63),
            ),
          if (_isFabMenuOpen) const SizedBox(height: 10),
          if (_isFabMenuOpen)
            FloatingActionButton.extended(
              heroTag: 'despesaBtn',
              onPressed: () {
                _toggleFabMenu();
                _showModal(context, const NovaDespesaModal());
              },
              label: const Text('Nova despesa',
                  style: TextStyle(color: Colors.white)),
              icon: const Icon(Icons.arrow_downward, color: Colors.white),
              backgroundColor: const Color(0xFFE91E63),
            ),
          if (_isFabMenuOpen) const SizedBox(height: 10),
          if (_isFabMenuOpen)
            FloatingActionButton.extended(
              heroTag: 'fecharBtn',
              onPressed: _toggleFabMenu,
              label:
                  const Text('Fechar', style: TextStyle(color: Colors.white)),
              icon: const Icon(Icons.close, color: Colors.white),
              backgroundColor: const Color(0xFFE91E63),
            ),
          if (_isFabMenuOpen)
            const SizedBox(
              height: 10,
            ),
          FloatingActionButton(
            heroTag: 'mainFabBtn',
            onPressed: _toggleFabMenu,
            backgroundColor: const Color(0xFFE91E63),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: Center(
        child: Text(
          'A tela de $title será criada aqui!',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
