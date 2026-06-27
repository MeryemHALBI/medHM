import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/analysis_provider.dart';
import 'result_screen.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Analyse en cours")),
      body: Consumer<AnalysisProvider>(
        builder: (context, provider, _) {
          // Une fois l'analyse terminée, on bascule automatiquement vers
          // l'écran de résultat.
          if (provider.status == AnalysisStatus.done) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const ResultScreen()),
              );
            });
          }

          if (provider.status == AnalysisStatus.error) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.redAccent),
                    const SizedBox(height: 16),
                    Text(provider.errorMessage ?? "Une erreur est survenue."),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Retour"),
                    ),
                  ],
                ),
              ),
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (provider.selectedImage != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      provider.selectedImage!,
                      height: 220,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 32),
                const CircularProgressIndicator(),
                const SizedBox(height: 24),
                const Text(
                  "Étage 1 — analyse locale (YOLO)...",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Si une anomalie est détectée, l'image sera envoyée\nau modèle cloud pour une classification précise.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
