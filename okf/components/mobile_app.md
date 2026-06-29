---
type: process
title: Application mobile Flutter
description: Application mobile implémentant l'étage 1 (YOLO local) et l'appel à l'étage 2 (backend cloud) en cas de détection.
resource: mobile-app/lib/main.dart
tags: [mobile, flutter, etage-1]
timestamp: 2026-06-29T00:00:00Z
---

# Application mobile Flutter

## Objectif

Implémenter l'[architecture hybride](../architecture/hybrid_pipeline.md)
côté utilisateur final : capture ou import d'image, détection locale via
[YOLO](../models/yolo_polype.md), puis appel conditionnel au
[backend FastAPI](backend_api.md) si une anomalie est détectée.

## Écrans

- Accueil — prendre une photo ou importer une image (caméra/galerie).
- Analyse — affichage du déroulé du pipeline en cours.
- Résultat — classe finale et niveau de confiance.

## Statut actuel

Structure de base posée (`lib/models`, `lib/services`, `lib/screens`).
Pipeline d'analyse actuellement **simulé** (mock) — l'appel réel au
modèle YOLO embarqué (TensorFlow Lite) et l'appel HTTP au backend ne
sont pas encore branchés ; les points d'intégration sont identifiés par
des commentaires `TODO` dans `pipeline_service.dart`.

Premiers tests sur émulateur Android en cours.

## Prochaines étapes

1. Convertir le modèle [YOLO](../models/yolo_polype.md) entraîné
   (`.pt`) au format `.tflite` pour l'intégration mobile.
2. Brancher l'appel réel au [backend FastAPI](backend_api.md) (code
   d'exemple déjà présent en commentaire dans le service de pipeline).
3. Tester sur appareil physique.
