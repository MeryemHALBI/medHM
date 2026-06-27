/// Représente le résultat complet d'une analyse d'image, à travers
/// les deux étages du pipeline hybride (YOLO local + EfficientNet cloud).
class AnalysisResult {
  /// True si l'étage 1 (YOLO) a détecté une anomalie suspecte.
  final bool anomalyDetected;

  /// "yolo_only" si on s'est arrêté à l'étage 1 (résultat = normal),
  /// "cloud" si l'étage 2 (EfficientNet) a été appelé.
  final String stage;

  /// Classe finale décidée : normal, polype, mici, mauvaise_preparation.
  final String finalClass;

  /// Confiance du modèle cloud (null si l'étage 2 n'a pas été appelé).
  final double? cloudConfidence;

  const AnalysisResult({
    required this.anomalyDetected,
    required this.stage,
    required this.finalClass,
    this.cloudConfidence,
  });

  /// Construit un résultat à partir de la réponse JSON du backend.
  factory AnalysisResult.fromCloudJson(
    Map<String, dynamic> json, {
    required bool anomalyDetected,
  }) {
    return AnalysisResult(
      anomalyDetected: anomalyDetected,
      stage: "cloud",
      finalClass: json["predicted_class"] as String,
      cloudConfidence: (json["confidence"] as num).toDouble(),
    );
  }

  /// Résultat court-circuité : l'étage 1 n'a rien détecté, pas d'appel cloud.
  factory AnalysisResult.normalFromYoloOnly() {
    return const AnalysisResult(
      anomalyDetected: false,
      stage: "yolo_only",
      finalClass: "normal",
      cloudConfidence: null,
    );
  }

  bool get isNormal => finalClass == "normal";
}
