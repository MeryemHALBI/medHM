---
type: index
title: medet — Détection et classification d'anomalies digestives
description: Bundle de connaissances du projet medet, couvrant les modèles entraînés, l'architecture hybride, le dataset, et les composants (POC, backend, application mobile).
timestamp: 2026-06-29T00:00:00Z
---

# medet — Bundle de connaissances

Ce bundle documente le projet **medet** : détection et classification
d'anomalies radiologiques du tube digestif (polypes, MICI, mauvaise
préparation) par computer vision et transfer learning.

## Sommaire

- [Architecture hybride](architecture/hybrid_pipeline.md) — vue d'ensemble
  du pipeline en deux étages (YOLO local + modèle cloud).
- [Dataset](data/deep_polypes.md) — description du jeu de données utilisé
  pour l'entraînement.
- Modèles entraînés :
  - [EfficientNet](models/efficientnet.md)
  - [Swin Transformer](models/swin_transformer.md)
  - [ResNet50](models/resnet50.md)
  - [ConvNeXt](models/convnext.md)
  - [ViT](models/vit.md)
  - [YOLO (étage 1)](models/yolo_polype.md)
- Composants :
  - [POC Streamlit](components/poc_streamlit.md)
  - [Backend FastAPI](components/backend_api.md)
  - [Application mobile Flutter](components/mobile_app.md)

Voir [log.md](log.md) pour l'historique des évolutions de ce bundle.
