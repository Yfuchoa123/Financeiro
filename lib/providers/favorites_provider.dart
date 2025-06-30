// lib/providers/favorites_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesNotifier extends StateNotifier<Map<String, bool>> {
  // Inicializa todos os itens favoritáveis como 'false'
  FavoritesNotifier()
      : super({
          'Visão geral': false,
          'Extrato de contas': false,
          'Cartões de crédito': false,
          'Relatórios': false,
        });

  // Lógica ATUALIZADA para garantir que apenas um item seja o favorito
  void setFavorite(String screenName) {
    final isCurrentlyFavorite = state[screenName] ?? false;

    // Cria um novo mapa com todos os valores como 'false'
    final newState = {for (var k in state.keys) k: false};

    // Se o item clicado NÃO era o favorito atual, ele se torna o novo favorito.
    // Se ele JÁ ERA o favorito, o clique serve para desmarcá-lo,
    // e o resultado é que todos os itens ficam como 'false'.
    if (!isCurrentlyFavorite) {
      newState[screenName] = true;
    }

    state = newState;
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, Map<String, bool>>((ref) {
  return FavoritesNotifier();
});
