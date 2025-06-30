// lib/screens/documentos_screen.dart

import 'package:flutter/material.dart';
import 'package:meu_financeiro_pessoal/widgets/custom_app_bar.dart';

class DocumentosScreen extends StatelessWidget {
  const DocumentosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Documentos'),
      //   // Mantendo o mesmo estilo da AppBar principal
      //   backgroundColor: const Color(0xFF00BFA5),
      //   foregroundColor: Colors.white,
      // ),
      // ADICIONE ISTO NO LUGAR:
      appBar: const CustomAppBar(title: 'Documentos'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline,
                size: 80,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 24),
              const Text(
                'Nenhum documento encontrado.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Os documentos que você enviar serão armazenados aqui e poderão ser anexados a lançamentos.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Lógica para fazer upload de um documento
        },
        backgroundColor: const Color(0xFFE91E63),
        child: const Icon(Icons.upload, color: Colors.white),
      ),
    );
  }
}
