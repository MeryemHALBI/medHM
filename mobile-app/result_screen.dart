import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/analysis_result.dart';
import '../services/analysis_provider.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  Color _colorForClass(String className) {
    switch (className) {
      case "normal":
        return Colors.green;
      case "polype":
      case "mici":
        return Colors.orange;
      case "mauvaise_preparation":
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  IconData _iconForClass(String className) {
    switch (className) {
      case "normal":
        return Icons.check_circle_outline;
      default:
        return Icons.warning_amber_outlined;
    }
  }

  String _labelForClass(String className) {
    switch (className) {
      case "normal":
        return "Normal";
      case "polype":
        return "Polype";
      case "mici":
        return "MICI";
      case "mauvaise_preparation":
        return "Mauvaise préparation";
      default:
        return className;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AnalysisProvider>();
    final AnalysisResult? result = provider.result;

    if (result == null) {
      return const Scaffold(
        body: Center(child: Text("Aucun résultat disponible.")),
      );
    }

    final color = _colorForClass(result.finalClass);

    return Scaffold(
      appBar: AppBar(title: const Text("Résultat de l'analyse")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
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
            Icon(_iconForClass(result.finalClass), size: 72, color: color),
            const SizedBox(height: 16),
            Text(
              _labelForClass(result.finalClass),
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            if (result.stage == "yolo_only")
              const Text(
                "Aucune anomalie détectée localement.\nAucun appel au modèle cloud n'a été nécessaire.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              )
            else
              Text(
                "Anomalie détectée localement, confirmée par le modèle cloud"
                "${result.cloudConfidence != null ? ' (confiance : ${(result.cloudConfidence! * 100).toStringAsFixed(0)}%)' : ''}.",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                provider.reset();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.refresh),
              label: const Text("Nouvelle analyse"),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(52)),
            ),
          ],
        ),
      ),
    );
  }
}
