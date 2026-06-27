import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;

import '../models/analysis_result.dart';

/// Service responsable d'exécuter le pipeline d'analyse hybride :
///   1. Étage 1 (YOLO, local)  -> détecte si une anomalie est présente
///   2. Étage 2 (EfficientNet, cloud) -> classifie précisément si besoin
///
/// MODE ACTUEL : simulation (mock). Le vrai modèle YOLO (.tflite) et
/// l'appel réseau vers le backend FastAPI ne sont pas encore branchés.
/// Voir les TODO ci-dessous pour les points d'intégration.
class PipelineService {
  /// URL du backend FastAPI (étage 2). À renseigner une fois le backend
  /// déployé. Exemple : "https://medet-api.example.com/predict"
  static const String backendUrl = "";

  final Random _random = Random();

  /// Exécute le pipeline complet sur une image et retourne le résultat.
  Future<AnalysisResult> analyze(File imageFile) async {
    // --- Étage 1 : YOLO local (actuellement simulé) ---
    final bool anomalyDetected = await _runYoloStage(imageFile);

    if (!anomalyDetected) {
      return AnalysisResult.normalFromYoloOnly();
    }

    // --- Étage 2 : EfficientNet cloud (actuellement simulé) ---
    return _runCloudStage(imageFile, anomalyDetected: anomalyDetected);
  }

  /// TODO (intégration réelle) :
  /// Remplacer ce mock par un vrai appel au modèle YOLO converti en
  /// TensorFlow Lite (package `tflite_flutter`), exécuté localement sur
  /// l'image, et retourner `true` si au moins une boîte est détectée.
  Future<bool> _runYoloStage(File imageFile) async {
    await Future.delayed(const Duration(milliseconds: 600)); // simule l'inférence
    return _random.nextDouble() < 0.55;
  }

  /// TODO (intégration réelle) :
  /// Remplacer ce mock par un vrai appel HTTP POST multipart vers
  /// `backendUrl` (voir backend/main.py, endpoint /predict), en envoyant
  /// `imageFile` et en parsant la réponse JSON avec
  /// `AnalysisResult.fromCloudJson`.
  Future<AnalysisResult> _runCloudStage(
    File imageFile, {
    required bool anomalyDetected,
  }) async {
    await Future.delayed(const Duration(milliseconds: 900)); // simule l'appel réseau

    const candidates = ["polype", "mici", "mauvaise_preparation"];
    final predictedClass = candidates[_random.nextInt(candidates.length)];
    final confidence = 0.75 + _random.nextDouble() * 0.23;

    return AnalysisResult(
      anomalyDetected: anomalyDetected,
      stage: "cloud",
      finalClass: predictedClass,
      cloudConfidence: confidence,
    );

    // --- Exemple d'implémentation réelle (à activer plus tard) ---
    // final uri = Uri.parse(backendUrl);
    // final request = http.MultipartRequest('POST', uri)
    //   ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));
    // final streamedResponse = await request.send();
    // final response = await http.Response.fromStream(streamedResponse);
    // final json = jsonDecode(response.body) as Map<String, dynamic>;
    // return AnalysisResult.fromCloudJson(json, anomalyDetected: anomalyDetected);
  }
}
