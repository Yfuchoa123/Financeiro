// lib/widgets/custom_app_bar.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_financeiro_pessoal/providers/favorites_provider.dart';
import 'package:meu_financeiro_pessoal/screens/cartoes_de_credito_screen.dart';
import 'package:meu_financeiro_pessoal/screens/extrato_de_contas_screen.dart';
import 'package:meu_financeiro_pessoal/screens/relatorios_screen.dart';
import 'package:meu_financeiro_pessoal/main.dart'; // Importamos o main para ter acesso ao DashboardScreen

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    // Função helper para navegar corretamente
    void navigateTo(BuildContext ctx, Widget screen) {
      // Se a tela atual for diferente da tela de destino
      if (ModalRoute.of(ctx)?.settings.name != screen.runtimeType.toString()) {
        Navigator.of(ctx).popUntil((route) => route.isFirst);
        // Não empurra a DashboardScreen novamente se já estivermos nela
        if (screen is! DashboardScreen) {
          Navigator.of(ctx).push(MaterialPageRoute(
            builder: (c) => screen,
            // Damos um nome para a rota para poder comparar
            settings: RouteSettings(name: screen.runtimeType.toString()),
          ));
        }
      }
    }

    // Mapeia todos os itens favoritáveis para seus ícones e telas
    final favoriteShortcuts = {
      'Visão geral': (
        Icons.apps,
        () {
          navigateTo(context, const DashboardScreen());
        }
      ),
      'Extrato de contas': (
        Icons.account_balance_wallet_outlined,
        () {
          navigateTo(context, const ExtratoDeContasScreen());
        }
      ),
      'Cartões de crédito': (
        Icons.credit_card_outlined,
        () {
          navigateTo(context, const CartoesDeCreditoScreen());
        }
      ),
      'Relatórios': (
        Icons.description_outlined,
        () {
          navigateTo(context, const RelatoriosScreen());
        }
      ),
    };

    final favoriteEntry = favorites.entries
        .firstWhere((e) => e.value, orElse: () => const MapEntry('', false));

    return AppBar(
      leading: leading,
      title: Row(
        children: [
          Text(title),
          if (favoriteEntry.key.isNotEmpty) ...[
            const VerticalDivider(
                width: 24, indent: 12, endIndent: 12, color: Colors.white54),
            Builder(builder: (context) {
              final shortcut = favoriteShortcuts[favoriteEntry.key];
              if (shortcut != null) {
                return IconButton(
                  icon: Icon(shortcut.$1),
                  tooltip: favoriteEntry.key,
                  onPressed: shortcut.$2,
                );
              }
              return const SizedBox.shrink();
            })
          ]
        ],
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
