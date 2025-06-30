// lib/screens/test_screen.dart

import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tela de Teste do Menu"),
      ),
      body: Center(
        child: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert,
              size: 40), // Ícone maior para facilitar o clique
          onSelected: (value) {
            // Este print é o mais importante.
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'editar',
              child: ListTile(
                  leading: Icon(Icons.edit), title: Text('Editar (Teste)')),
            ),
            const PopupMenuItem<String>(
              value: 'excluir',
              child: ListTile(
                  leading: Icon(Icons.delete), title: Text('Excluir (Teste)')),
            ),
          ],
        ),
      ),
    );
  }
}
