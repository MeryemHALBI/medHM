---
type: process
title: Architecture hybride — pipeline en deux étages
description: Pipeline de détection combinant un modèle YOLO léger embarqué localement et un modèle de classification plus lourd appelé à la demande sur le cloud.
tags: [architecture, pipeline, yolo, efficientnet]
timestamp: 2026-06-29T00:00:00Z
---

# Architecture hybride

## Contexte

Les modèles de classification comparés (voir
[EfficientNet](../models/efficientnet.md),
[Swin Transformer](../models/swin_transformer.md), etc.) atteignent une
bonne précision mais sont trop lourds pour tourner en continu sur un
appareil mobile. L'architecture hybride répond à ce problème en séparant
la détection rapide de la classification précise.

## Fonctionnement

1. **Étage 1 — local (mobile)** : le modèle [YOLO](../models/yolo_polype.md)
   (nano ou small) analyse l'image directement sur l'appareil. Il répond à
   une question binaire : une anomalie est-elle présente ou non ?
2. **Filtre de décision** :
   - Si aucune anomalie n'est détectée → résultat final `normal`, sans
     appel réseau.
   - Si une anomalie est détectée → l'image est envoyée à l'étage 2.
3. **Étage 2 — cloud (à la demande)** : un modèle de classification
   (actuellement [EfficientNet](../models/efficientnet.md)) reçoit
   l'image via le [backend FastAPI](../components/backend_api.md) et
   renvoie la classe précise parmi les 4 catégories.

## Classes détectées

- `normal`
- `polype`
- `mici`
- `mauvaise_preparation`

## Évolution future envisagée

Une implémentation hybride Swin/YOLO à flux continu a été évoquée : une
partie du traitement s'effectuerait en continu sur l'application mobile,
les résultats intermédiaires (features compressées) seraient ensuite
envoyés au backbone cloud pour poursuivre l'inférence. Cette approche est
plus complexe et a été mise de côté en faveur de l'implémentation simple
décrite ci-dessus, qui sert de première étape.

## Implémentations associées

- [POC Streamlit](../components/poc_streamlit.md) — démonstration du
  pipeline complet pour l'équipe métier.
- [Backend FastAPI](../components/backend_api.md) — expose l'étage 2.
- [Application mobile Flutter](../components/mobile_app.md) — implémente
  l'étage 1 et appelle l'étage 2 si nécessaire.
