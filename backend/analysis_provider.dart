import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/analysis_result.dart';
import '../services/pipeline_service.dart';

enum AnalysisStatus { idle, analyzing, done, error }

/// État partagé de l'analyse en cours, observé par les écrans
/// (accueil, analyse, résultat) via Provider.
class AnalysisProvider extends ChangeNotifier {
  final PipelineService _pipelineService = PipelineService();

  File? _selectedImage;
  AnalysisStatus _status = AnalysisStatus.idle;
  AnalysisResult? _result;
  String? _errorMessage;

  File? get selectedImage => _selectedImage;
  AnalysisStatus get status => _status;
  AnalysisResult? get result => _result;
  String? get errorMessage => _errorMessage;

  /// Démarre une nouvelle analyse à partir d'une image (caméra ou galerie).
  Future<void> startAnalysis(File imageFile) async {
    _selectedImage = imageFile;
    _status = AnalysisStatus.analyzing;
    _result = null;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _pipelineService.analyze(imageFile);
      _result = result;
      _status = AnalysisStatus.done;
    } catch (e) {
      _errorMessage = "Erreur lors de l'analyse : $e";
      _status = AnalysisStatus.error;
    }

    notifyListeners();
  }

  /// Réinitialise l'état pour repartir sur une nouvelle analyse.
  void reset() {
    _selectedImage = null;
    _status = AnalysisStatus.idle;
    _result = null;
    _errorMessage = null;
    notifyListeners();
  }
}
